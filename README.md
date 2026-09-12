# Karismatik — Application de commande en ligne

Application complète : page client (commande), page admin (menu du jour + commandes),
base de données Supabase, hébergement Render, code sur GitHub.

## Contenu du dépôt
- `index.html` — page client (le menu, la commande)
- `admin.html` — espace admin (activer les plats, voir les commandes)
- `styles.css` — le style partagé
- `config.js` — tes clés Supabase et ton numéro WhatsApp (à remplir)
- `supabase.sql` — les tables + le menu de départ
- `logo.png` + `images/` — le logo et les photos des plats

---

## Étape A — Supabase (la base de données)

1. Va sur https://supabase.com , crée un compte, puis **New project**.
   Note le mot de passe de la base. Choisis la région la plus proche.
2. Ouvre **SQL Editor > New query**. Colle tout le contenu de `supabase.sql`, puis **Run**.
   Les tables et le menu sont créés.
3. Crée ton compte admin : **Authentication > Users > Add user**.
   Mets ton email et un mot de passe. (Pas d'inscription publique, c'est voulu.)
4. Récupère tes clés : **Project Settings > API**.
   Copie **Project URL** et la clé **anon public**.
5. Ouvre `config.js` et remplace les trois valeurs :
   - `SUPABASE_URL` par ton Project URL
   - `SUPABASE_ANON_KEY` par ta clé anon public
   - `WHATSAPP` par le numéro de Karismatik (format `226...`, sans `+`)

> La clé anon est publique, c'est normal. La sécurité vient des règles RLS
> déjà posées par `supabase.sql` : le public lit le menu et crée une commande,
> seul l'admin connecté modifie le menu et lit les commandes.

---

## Étape B — GitHub (le code)

1. Crée un compte sur https://github.com , puis **New repository**.
   Nom : `karismatik-app`. Laisse-le public ou privé, au choix.
2. Le plus simple sans ligne de commande : sur la page du dépôt vide,
   clique **uploading an existing file**, glisse tous les fichiers de ce dossier
   (y compris le dossier `images`), puis **Commit changes**.
3. Plus tard, en ligne de commande :
   ```
   git init
   git add .
   git commit -m "Karismatik v1"
   git branch -M main
   git remote add origin https://github.com/TON-COMPTE/karismatik-app.git
   git push -u origin main
   ```

---

## Étape C — Render (la mise en ligne)

1. Va sur https://render.com , connecte-toi avec GitHub.
2. **New > Static Site**, choisis le dépôt `karismatik-app`.
3. Réglages :
   - **Build Command** : laisse vide
   - **Publish Directory** : `.`  (un point)
4. **Create Static Site**. Render publie et te donne une adresse en `.onrender.com`.
   À chaque `push` sur GitHub, Render met le site à jour tout seul.

Le client commande sur `.../index.html`. Toi, tu gères sur `.../admin.html`.

---

## Le test qui prouve que tout marche
Sur un téléphone, ouvre `index.html`, passe une commande.
Sur un autre appareil, ouvre `admin.html`, connecte-toi, onglet **Commandes**.
La commande doit apparaître. Si oui, la base fonctionne de bout en bout.

## Au quotidien
- Chaque matin, ouvre `admin.html` sur ton téléphone, onglet **Menu du jour**,
  et bascule les interrupteurs des plats disponibles.
- Les commandes arrivent seules dans l'onglet **Commandes**, avec le récapitulatif
  complet de chacune. Rien n'est envoyé sur WhatsApp, tout reste dans le tableau de bord.

## Affichage en direct des commandes
Pour que chaque nouvelle commande apparaisse sans rafraîchir, active Realtime sur la
table `commandes` : Supabase > **Database > Replication**, coche `commandes`. Le bouton
**Rafraîchir** de l'onglet Commandes reste là si besoin.

## Changer le menu
Ajoute ou modifie des plats dans Supabase : **Table Editor > plats**.
Pour une photo, dépose le fichier dans `images/`, pousse sur GitHub, et mets
le chemin `images/nom.jpg` dans la colonne `image` du plat.
