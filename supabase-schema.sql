-- In Supabase im SQL Editor ausführen.
-- Erstellt private Buchungen und Einstellungen pro eingeloggtem Benutzer.

create table if not exists public.bookings (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade default auth.uid(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  date date not null,
  type text not null check (type in ('Ausgabe','Einnahme','Transfer')),
  amount numeric(12,2) not null check (amount >= 0),
  category text not null,
  account text not null,
  target_account text,
  description text,
  receipt_data text
);

create table if not exists public.app_settings (
  user_id uuid primary key references auth.users(id) on delete cascade default auth.uid(),
  updated_at timestamptz not null default now(),
  categories text[] not null default '{}',
  accounts text[] not null default '{}'
);

alter table public.bookings enable row level security;
alter table public.app_settings enable row level security;

drop policy if exists "bookings_select_own" on public.bookings;
drop policy if exists "bookings_insert_own" on public.bookings;
drop policy if exists "bookings_update_own" on public.bookings;
drop policy if exists "bookings_delete_own" on public.bookings;

create policy "bookings_select_own" on public.bookings for select using (auth.uid() = user_id);
create policy "bookings_insert_own" on public.bookings for insert with check (auth.uid() = user_id);
create policy "bookings_update_own" on public.bookings for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "bookings_delete_own" on public.bookings for delete using (auth.uid() = user_id);

drop policy if exists "settings_select_own" on public.app_settings;
drop policy if exists "settings_insert_own" on public.app_settings;
drop policy if exists "settings_update_own" on public.app_settings;

create policy "settings_select_own" on public.app_settings for select using (auth.uid() = user_id);
create policy "settings_insert_own" on public.app_settings for insert with check (auth.uid() = user_id);
create policy "settings_update_own" on public.app_settings for update using (auth.uid() = user_id) with check (auth.uid() = user_id);

create index if not exists bookings_user_date_idx on public.bookings(user_id, date desc);
