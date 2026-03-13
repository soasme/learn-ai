import { readFile } from "node:fs/promises";
import path from "node:path";

export type ChapterManifest = {
  slug: string;
  title: string;
  summary: string;
  text: string;
  code: string;
  entrypoint: string;
};

export type BookManifest = {
  title: string;
  subtitle: string;
  author: string;
  chapters: ChapterManifest[];
};

export async function getBookManifest(): Promise<BookManifest> {
  const manifestPath = path.join(process.cwd(), "book", "manifest.json");
  const raw = await readFile(manifestPath, "utf8");
  return JSON.parse(raw) as BookManifest;
}
