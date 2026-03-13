from __future__ import annotations

import argparse
import json
import shutil
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BOOK_DIR = ROOT / "book"
DIST_DIR = ROOT / "dist"


@dataclass(frozen=True)
class Chapter:
    slug: str
    title: str
    summary: str
    text_path: Path
    code_path: Path
    entrypoint: Path


@dataclass(frozen=True)
class Manifest:
    title: str
    subtitle: str
    author: str
    chapters: list[Chapter]


def load_manifest() -> Manifest:
    raw = json.loads((BOOK_DIR / "manifest.json").read_text())
    chapters = []
    for item in raw["chapters"]:
        chapters.append(
            Chapter(
                slug=item["slug"],
                title=item["title"],
                summary=item["summary"],
                text_path=ROOT / item["text"],
                code_path=ROOT / item["code"],
                entrypoint=ROOT / item.get("entrypoint", item["code"]),
            )
        )

    return Manifest(
        title=raw["title"],
        subtitle=raw["subtitle"],
        author=raw["author"],
        chapters=chapters,
    )


def ensure_manifest_files(manifest: Manifest) -> None:
    for chapter in manifest.chapters:
        for path in (chapter.text_path, chapter.code_path, chapter.entrypoint):
            if not path.exists():
                raise FileNotFoundError(f"Missing required file: {path}")


def run_chapter(chapter: Chapter) -> dict[str, object]:
    completed = subprocess.run(
        [sys.executable, str(chapter.entrypoint)],
        cwd=ROOT,
        capture_output=True,
        text=True,
        check=False,
    )
    code = chapter.code_path.read_text()
    stdout_lines = completed.stdout.strip().splitlines()

    return {
        "chapter": chapter.slug,
        "title": chapter.title,
        "entrypoint": str(chapter.entrypoint.relative_to(ROOT)),
        "loc": len(code.splitlines()),
        "exit_code": completed.returncode,
        "stdout_tail": stdout_lines[-8:],
        "stderr": completed.stderr.strip(),
    }


def render_book(manifest: Manifest) -> str:
    parts = [
        f"= {manifest.title}",
        manifest.subtitle,
        "",
        f"_Author: {manifest.author}_",
        "",
    ]

    for index, chapter in enumerate(manifest.chapters):
        if index:
            parts.extend(["", "#pagebreak()", ""])

        parts.extend(
            [
                f"= {chapter.title}",
                "",
                chapter.text_path.read_text().strip(),
                "",
                "== Runnable code",
                "",
                "```python",
                chapter.code_path.read_text().rstrip(),
                "```",
            ]
        )

    return "\n".join(parts) + "\n"


def write_outputs(manifest: Manifest, report: list[dict[str, object]]) -> Path:
    DIST_DIR.mkdir(exist_ok=True)
    typ_path = DIST_DIR / "learn-ml.typ"
    report_path = DIST_DIR / "chapter-report.json"
    typ_path.write_text(render_book(manifest))
    report_path.write_text(json.dumps(report, indent=2))
    return typ_path


def maybe_compile_typst(typ_path: Path) -> None:
    typst = shutil.which("typst")
    if not typst:
        print("typst not found; wrote dist/learn-ml.typ only.")
        return

    pdf_path = DIST_DIR / "learn-ml.pdf"
    subprocess.run(
        [typst, "compile", str(typ_path), str(pdf_path)],
        cwd=ROOT,
        check=True,
    )
    print(f"compiled {pdf_path.relative_to(ROOT)}")


def command_check() -> int:
    manifest = load_manifest()
    ensure_manifest_files(manifest)
    report = [run_chapter(chapter) for chapter in manifest.chapters]

    for item in report:
        print(
            f"{item['chapter']}: exit_code={item['exit_code']} "
            f"loc={item['loc']} entrypoint={item['entrypoint']}"
        )
        for line in item["stdout_tail"]:
            print(f"  {line}")
        if item["stderr"]:
            print(f"  stderr: {item['stderr']}")

    return 0 if all(item["exit_code"] == 0 for item in report) else 1


def command_build() -> int:
    manifest = load_manifest()
    ensure_manifest_files(manifest)
    report = [run_chapter(chapter) for chapter in manifest.chapters]

    if any(item["exit_code"] != 0 for item in report):
        for item in report:
            if item["exit_code"] != 0:
                print(f"build blocked: {item['chapter']} exited with {item['exit_code']}")
        return 1

    typ_path = write_outputs(manifest, report)
    print(f"wrote {typ_path.relative_to(ROOT)}")
    maybe_compile_typst(typ_path)
    return 0


def main() -> int:
    parser = argparse.ArgumentParser(description="Learn ML ebook builder")
    parser.add_argument("command", choices=["check", "build"])
    args = parser.parse_args()

    if args.command == "check":
        return command_check()
    return command_build()


if __name__ == "__main__":
    raise SystemExit(main())
