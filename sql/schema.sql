DROP TABLE IF EXISTS research_notes;
DROP TABLE IF EXISTS daily_token_metrics;
DROP TABLE IF EXISTS tokens;
DROP TABLE IF EXISTS daily_protocol_metrics;
DROP TABLE IF EXISTS protocols;
DROP TABLE IF EXISTS chains;
DROP TABLE IF EXISTS sectors;

CREATE TABLE sectors (
    sector_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE chains (
    chain_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    ecosystem_type VARCHAR(100),
    description TEXT
);

CREATE TABLE protocols (
    protocol_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    sector_id INTEGER REFERENCES sectors(sector_id),
    chain_id INTEGER REFERENCES chains(chain_id),
    token_symbol VARCHAR(20),
    description TEXT
);

CREATE TABLE daily_protocol_metrics (
    metric_id SERIAL PRIMARY KEY,
    protocol_id INTEGER NOT NULL REFERENCES protocols(protocol_id),
    date DATE NOT NULL,
    tvl NUMERIC,
    fees NUMERIC,
    revenue NUMERIC,
    volume NUMERIC,
    active_users INTEGER,
    transactions INTEGER,
    UNIQUE (protocol_id, date)
);

CREATE TABLE tokens (
    token_id SERIAL PRIMARY KEY,
    protocol_id INTEGER REFERENCES protocols(protocol_id),
    symbol VARCHAR(20) NOT NULL,
    name VARCHAR(100),
    coingecko_id VARCHAR(100),
    UNIQUE (symbol, coingecko_id)
);

CREATE TABLE daily_token_metrics (
    token_metric_id SERIAL PRIMARY KEY,
    token_id INTEGER NOT NULL REFERENCES tokens(token_id),
    date DATE NOT NULL,
    price NUMERIC,
    market_cap NUMERIC,
    volume NUMERIC,
    fully_diluted_valuation NUMERIC,
    UNIQUE (token_id, date)
);

CREATE TABLE research_notes (
    note_id SERIAL PRIMARY KEY,
    protocol_id INTEGER NOT NULL REFERENCES protocols(protocol_id),
    thesis TEXT,
    bull_case TEXT,
    bear_case TEXT,
    risks TEXT,
    sources TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
