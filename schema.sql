-- ============================================================
-- CAFESIA — PostgreSQL Schema
-- Basado en los datos harcodeados de las templates
-- ============================================================

-- CATEGORÍAS (menú y plantas)
CREATE TABLE categories (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    slug        VARCHAR(100) NOT NULL UNIQUE,
    type        VARCHAR(20)  NOT NULL CHECK (type IN ('menu', 'plant', 'section')),
    sort_order  INT          NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- ITEMS DEL MENÚ (café, pan, bebidas, comida)
CREATE TABLE menu_items (
    id          SERIAL PRIMARY KEY,
    category_id INT          NOT NULL REFERENCES categories(id),
    name        VARCHAR(200) NOT NULL,
    description TEXT,
    price       VARCHAR(50)  DEFAULT '—',
    image       VARCHAR(255),
    available   BOOLEAN      NOT NULL DEFAULT true,
    sort_order  INT          NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- PLANTAS (vivero / jardín)
CREATE TABLE plants (
    id          SERIAL PRIMARY KEY,
    category_id INT          REFERENCES categories(id),
    name        VARCHAR(200) NOT NULL,
    description TEXT,
    origin      VARCHAR(100) DEFAULT 'Maya',
    image       VARCHAR(255),
    available   BOOLEAN      NOT NULL DEFAULT true,
    sort_order  INT          NOT NULL DEFAULT 0,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- SECCIONES DEL HOME (café, pan, bebidas, alimentos, plantas, tour)
CREATE TABLE sections (
    id          SERIAL PRIMARY KEY,
    slug        VARCHAR(100) NOT NULL UNIQUE,
    name        VARCHAR(200) NOT NULL,
    subtitle    VARCHAR(200),
    description TEXT,
    image       VARCHAR(255),
    button_text VARCHAR(100),
    button_link VARCHAR(255),
    sort_order  INT          NOT NULL DEFAULT 0,
    visible     BOOLEAN      NOT NULL DEFAULT true,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- TOURS (recorrido botánico guiado)
CREATE TABLE tours (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(200) NOT NULL,
    description TEXT,
    image       VARCHAR(255),
    button_text VARCHAR(100) DEFAULT 'Conocer',
    button_link VARCHAR(255),
    duration    VARCHAR(100),
    price       VARCHAR(50),
    schedule    TEXT,
    available   BOOLEAN      NOT NULL DEFAULT true,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now(),
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- EQUIPO
CREATE TABLE team (
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(200) NOT NULL,
    role        VARCHAR(200),
    photo       VARCHAR(255),
    bio         TEXT,
    sort_order  INT          NOT NULL DEFAULT 0,
    visible     BOOLEAN      NOT NULL DEFAULT true,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- TESTIMONIOS / RESEÑAS
CREATE TABLE testimonials (
    id          SERIAL PRIMARY KEY,
    author      VARCHAR(200) NOT NULL,
    content     TEXT         NOT NULL,
    rating      INT          CHECK (rating >= 1 AND rating <= 5),
    visible     BOOLEAN      NOT NULL DEFAULT true,
    created_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- CONFIGURACIÓN (contacto, horarios, redes sociales, SEO)
CREATE TABLE settings (
    key         VARCHAR(100) PRIMARY KEY,
    value       TEXT         NOT NULL,
    updated_at  TIMESTAMPTZ  NOT NULL DEFAULT now()
);

-- ============================================================
-- SEED: CONFIGURACIÓN
-- ============================================================
INSERT INTO settings (key, value) VALUES
    ('site_name',        'Cafesia'),
    ('site_description', 'Café de especialidad. Jardín botánico. Desde 2023.'),
    ('phone',            '999 200 2793'),
    ('email',            'cafesia.mx@gmail.com'),
    ('address',          'Interior del Jardín Botánico Regional Roger Orellana (CICY)'),
    ('address_line2',    'C. 43 130, Chuburná de Hidalgo, 97205'),
    ('hours',            'Martes a domingo: 8:00 — 18:00'),
    ('hours_closed',     'Lunes: cerrado'),
    ('instagram',        'https://www.instagram.com/cafesia_mx/'),
    ('facebook',         'https://www.facebook.com/p/Cafesia-61575987452815/'),
    ('whatsapp',         'https://wa.me/529992002793'),
    ('maps_url',         'https://www.google.com/maps/dir/?api=1&destination=CICY+Merida+Yucatan'),
    ('hero_title',       'Cafesia'),
    ('hero_image',       'Hero.webp'),
    ('hero_pattern',     'patron_fondo.webp'),
    ('footer_tagline',   'Hecho con granos y dedicación'),
    ('founding_year',    '2023');

-- ============================================================
-- SEED: CATEGORÍAS
-- ============================================================
INSERT INTO categories (name, slug, type, sort_order) VALUES
    ('Café',             'cafe',     'menu',    1),
    ('Panadería',        'pan',      'menu',    2),
    ('Bebidas',          'bebidas',  'menu',    3),
    ('Alimentos',        'alimentos','menu',    4),
    ('Plantas',          'plantas',  'plant',   1);

-- ============================================================
-- SEED: MENÚ
-- ============================================================
INSERT INTO menu_items (category_id, name, description, price, image, sort_order) VALUES
    (1, 'Café de especialidad',
        'Tueste artesanal que despierta el fruto. Cada lote es seleccionado a mano.',
        '—', 'VasoArtistico.webp', 1),
    (2, 'Pan artesanal',
        'Harina, agua, paciencia. Fermentación lenta, horno de piedra.',
        '—', 'BebidasPan.webp', 1),
    (3, 'Bebidas botánicas',
        'Infusiones de la colección viva del jardín. Tés fríos y calientes.',
        '—', 'todo.webp', 1),
    (4, 'Comida saludable',
        'Plato consciente, ingrediente local. Ensaladas, bowls y opciones veganas.',
        '—', 'Bowl.webp', 1);

-- ============================================================
-- SEED: PLANTAS
-- ============================================================
INSERT INTO plants (category_id, name, description, origin, sort_order) VALUES
    (5, 'Helecho cuerno de alce',  'Planta epífita de crecimiento lento. Ideal para interiores con luz indirecta.',  'Maya', 1),
    (5, 'Suculenta cola de burro', 'Resistente y de bajo mantenimiento. Perfecta para principiantes.',              'Maya', 2),
    (5, 'Palma camedor',           'Palma de interior que purifica el aire. Originaria de selvas tropicales.',       'Maya', 3),
    (5, 'Cafeto arábica',          'La planta que da origen a nuestro café. Hermosa y productiva.',                 'Maya', 4),
    (5, 'Menta piperita',          'Aromática y refrescante. Usada en nuestras infusiones botánicas.',              'Maya', 5),
    (5, 'Orquídea brassavola',     'Orquídea nativa de la región. Floración fragante y elegante.',                  'Maya', 6);

-- ============================================================
-- SEED: SECCIONES DEL HOME
-- ============================================================
INSERT INTO sections (slug, name, subtitle, description, image, button_text, button_link, sort_order) VALUES
    ('cafe',     'Café de especialidad',   'Café',
        'Tueste artesanal que despierta el fruto. Cada lote es seleccionado a mano, tostado en pequeñas cantidades y preparado con precisión para revelar los matices que el suelo y el clima regalaron al grano.',
        'VasoArtistico.webp', 'Ver más', '/cafesia/catalogo#contenido', 1),
    ('pan',      'Pan dulce artesanal',    'Panadería',
        'Piezas seleccionadas de panadería artesanal con ese toque dulce que acompaña la pausa del café. Cada bocado es un pequeño placer que completa la experiencia.',
        'BebidasPan.webp', 'Ver más', '/cafesia/catalogo#contenido', 2),
    ('bebidas',  'Bebidas deliciosas',     'Bebidas',
        'Infusiones de la colección viva del jardín. Tés fríos y calientes elaborados con hierbas, flores y frutos de temporada. Cada sorbo es un recorrido por los aromas que la tierra maya ofrece en silencio.',
        'todo.webp', 'Ver más', '/cafesia/catalogo#contenido', 3),
    ('alimentos','Comida saludable',       'Alimentos',
        'Plato consciente, ingrediente local. Ensaladas de temporada, bowls nutritivos y opciones veganas preparadas con lo que el jardín y el mercado ofrecen. Comer acá es volver a lo simple, sin renunciar al sabor.',
        'Bowl.webp', 'Ver más', '/cafesia/catalogo#contenido', 4),
    ('plantas',  'Plantas del jardín',     'Catálogo',
        'Un inventario vivo de especies nativas y exóticas que conviven en el suelo maya. Cada planta cuenta una historia de adaptación, resistencia y belleza. Descubrí nuestra colección y llevate un pedazo del jardín a casa.',
        'VentaPlantas.webp', 'Explorar', '/cafesia/catalogo?tab=plantas#contenido', 5),
    ('tour',     'Tour botánico guiado',   'Recorrido',
        'Caminar el jardín con el CICY es asistir a una conversación entre siglos: folklore, ciencia, la memoria biológica de una región que no olvida su lengua verde. Una observación profunda que no busca explicar, sino escuchar.',
        'JardinBotanico.webp', 'Conocer', '/cafesia/catalogo?tab=plantas#contenido', 6);

-- ============================================================
-- SEED: TOURS
-- ============================================================
INSERT INTO tours (name, description, image, button_text, button_link, duration, price, schedule) VALUES
    ('Tour botánico guiado',
     'Caminar el jardín con el CICY es asistir a una conversación entre siglos: folklore, ciencia, la memoria biológica de una región que no olvida su lengua verde.',
     'JardinBotanico.webp',
     'Conocer', '/cafesia/catalogo?tab=plantas#contenido',
     '60 min', 'Consultar', 'Sujeto a disponibilidad');

-- ============================================================
-- SEED: EQUIPO
-- ============================================================
INSERT INTO team (name, role, sort_order) VALUES
    ('El equipo de Cafesia', 'Fundadores', 1);

-- ============================================================
-- SEED: TESTIMONIAL (placeholder)
-- ============================================================
INSERT INTO testimonials (author, content, rating) VALUES
    ('—', 'Creemos que la verdadera sofisticación reside en la sencillez.', 5);
