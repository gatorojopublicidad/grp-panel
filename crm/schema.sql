-- CRM Servymaq · GRP  (ejecutar en Supabase > SQL Editor)
create table if not exists public.leads (
  id            uuid primary key default gen_random_uuid(),
  created_at    timestamptz not null default now(),
  cliente       text not null default 'Servymaq',
  plataforma    text not null check (plataforma in ('meta','google','manual')),
  campana       text,
  conjunto      text,
  anuncio       text,
  nombre        text,
  telefono      text,
  email         text,
  mensaje       text,
  estado        text not null default 'nuevo'
                check (estado in ('nuevo','contactado','cotizado','cerrado','perdido')),
  valor         numeric(14,2) default 0,
  notas         text,
  contactado_at timestamptz,
  cerrado_at    timestamptz,
  external_id   text unique   -- id del lead en Meta/Google: evita duplicados
);

create index if not exists leads_estado_idx on public.leads(estado);
create index if not exists leads_created_idx on public.leads(created_at desc);

-- Seguridad: solo usuarios autenticados (el equipo GRP) leen/editan.
-- Make inserta con la service_role key, que ignora RLS (nunca va en el panel).
alter table public.leads enable row level security;
create policy "equipo lee"     on public.leads for select to authenticated using (true);
create policy "equipo inserta" on public.leads for insert to authenticated with check (true);
create policy "equipo edita"   on public.leads for update to authenticated using (true);
create policy "equipo borra"   on public.leads for delete to authenticated using (true);
