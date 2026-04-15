-- Run this once in your Supabase SQL Editor
-- Dashboard → SQL Editor → New Query → paste → Run

create table if not exists daily_thought (
  id   text primary key,
  data jsonb not null default '{}'::jsonb
);

-- Allow anyone (anon) to read and upsert
alter table daily_thought enable row level security;

create policy "public read" on daily_thought
  for select using (true);

create policy "public upsert" on daily_thought
  for insert with check (true);

create policy "public update" on daily_thought
  for update using (true);

-- The `data` column stores a single JSON object with these keys:
--   topicState    : { "kw:TopicName": { checked, notes[] }, ... }
--   quoteNotes    : { "q:QuotePrefix": notes[], ... }
--   savedQuotes   : [{ text, author, tag }, ...]
--   extraKeyword  : ["Custom Keyword 1", ...]
--   extraSentence : ["Custom sentence?", ...]
--   extraQuotes   : { motivation:[], mindfulness:[], growth:[], courage:[] }
