# CRM de leads · Servymaq (piloto)

## 1. Supabase (10 min)
1. Crear proyecto en supabase.com (plan gratuito).
2. SQL Editor → pegar y ejecutar `crm/schema.sql`.
3. Authentication → Users → *Add user* (correo + contraseña para el equipo GRP).
   Authentication → Providers → Email: desactivar "Allow new users to sign up".
4. Settings → API: copiar **Project URL** y **anon key** (van en el panel, pestaña Leads → ⚙).
   La **service_role key** NO va en el panel: solo en Make.

## 2. Make: Meta Lead Ads → Supabase
Escenario: `Facebook Lead Ads: Watch Leads` → `HTTP: Make a request`
- URL: `https://<PROYECTO>.supabase.co/rest/v1/leads?on_conflict=external_id`
- Método POST, headers:
  - `apikey`: service_role key
  - `Authorization`: `Bearer <service_role key>`
  - `Content-Type`: `application/json`
  - `Prefer`: `resolution=ignore-duplicates`
- Body JSON:
```json
{
  "cliente": "Servymaq",
  "plataforma": "meta",
  "external_id": "{{leadgen_id}}",
  "campana": "{{campaign_name}}",
  "conjunto": "{{adset_name}}",
  "anuncio": "{{ad_name}}",
  "nombre": "{{full_name}}",
  "telefono": "{{phone_number}}",
  "email": "{{email}}"
}
```
Añadir un módulo final (WhatsApp/Gmail) que avise al equipo de ventas de Servymaq.

## 3. Make: Google Ads → Supabase
Módulo `Google Ads: Watch Lead Form Submissions` (o webhook de Lead Form Extension),
mismo `HTTP` anterior con `"plataforma": "google"`.

## 4. Panel
Abrir el panel → pestaña **Leads** → ⚙ → pegar URL y anon key → iniciar sesión.
Sin configurar, la pestaña funciona en modo demo local (datos de prueba en el navegador).
