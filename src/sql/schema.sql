BEGIN;

-- download_history
DROP TABLE IF EXISTS download_history;
CREATE UNLOGGED TABLE IF NOT EXISTS download_history
(
    id              SERIAL PRIMARY KEY,
    requested_date  DATE NOT NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- yearly_avg_price
DROP TABLE IF EXISTS yearly_avg_price;
CREATE TABLE IF NOT EXISTS yearly_avg_price (
  date_year      INTEGER PRIMARY KEY,
  average_price  DOUBLE PRECISION
);

-- region_price_gain
DROP TABLE IF EXISTS region_price_gain;
CREATE TABLE IF NOT EXISTS region_price_gain (
  region_name  TEXT PRIMARY KEY,
  first_date   DATE,
  first_price  DOUBLE PRECISION,
  last_date    DATE,
  last_price   DOUBLE PRECISION,
  price_gain   DOUBLE PRECISION
);

--
DROP TABLE IF EXISTS house_price_index_staging;
CREATE UNLOGGED TABLE IF NOT EXISTS house_price_index_staging
(
    date                     DATE,
    region_name              TEXT,
    area_code                TEXT,
    average_price            DOUBLE PRECISION,
    index                    DOUBLE PRECISION,
    index_sa                 DOUBLE PRECISION,
    change_1m                DOUBLE PRECISION,
    change_12m               DOUBLE PRECISION,
    average_price_sa         DOUBLE PRECISION,
    sales_volume             DOUBLE PRECISION,
    detached_price           DOUBLE PRECISION,
    detached_index           DOUBLE PRECISION,
    detached1m_change        DOUBLE PRECISION,
    detached12m_change       DOUBLE PRECISION,
    semi_detached_price      DOUBLE PRECISION,
    semi_detached_index      DOUBLE PRECISION,
    semi_detached1m_change   DOUBLE PRECISION,
    semi_detached12m_change  DOUBLE PRECISION,
    terraced_price           DOUBLE PRECISION,
    terraced_index           DOUBLE PRECISION,
    terraced1m_change        DOUBLE PRECISION,
    terraced12m_change       DOUBLE PRECISION,
    flat_price               DOUBLE PRECISION,
    flat_index               DOUBLE PRECISION,
    flat1m_change            DOUBLE PRECISION,
    flat12m_change           DOUBLE PRECISION,
    cash_price               DOUBLE PRECISION,
    cash_index               DOUBLE PRECISION,
    cash1m_change            DOUBLE PRECISION,
    cash12m_change           DOUBLE PRECISION,
    cash_sales_volume        DOUBLE PRECISION,
    mortgage_price           DOUBLE PRECISION,
    mortgage_index           DOUBLE PRECISION,
    mortgage1m_change        DOUBLE PRECISION,
    mortgage12m_change       DOUBLE PRECISION,
    mortgage_salesvolume     DOUBLE PRECISION,
    ftb_price                DOUBLE PRECISION,
    ftb_index                DOUBLE PRECISION,
    ftb1m_change             DOUBLE PRECISION,
    ftb12m_change            DOUBLE PRECISION,
    foo_price                DOUBLE PRECISION,
    foo_index                DOUBLE PRECISION,
    foo1m_change             DOUBLE PRECISION,
    foo12m_change            DOUBLE PRECISION,
    new_price                DOUBLE PRECISION,
    new_index                DOUBLE PRECISION,
    new1m_change             DOUBLE PRECISION,
    new12m_change            DOUBLE PRECISION,
    new_sales_volume         DOUBLE PRECISION,
    old_price                DOUBLE PRECISION,
    old_index                DOUBLE PRECISION,
    old1m_change             DOUBLE PRECISION,
    old12m_change            DOUBLE PRECISION,
    old_sales_volume         DOUBLE PRECISION
);

-- house_price_index
DROP TABLE IF EXISTS house_price_index;
CREATE UNLOGGED TABLE IF NOT EXISTS house_price_index
(
    date                     DATE NOT NULL,
    date_year                NUMERIC GENERATED ALWAYS AS (EXTRACT(year FROM date)) STORED,
    region_name              TEXT,
    area_code                TEXT,
    average_price            DOUBLE PRECISION,
    index                    DOUBLE PRECISION,
    index_sa                 DOUBLE PRECISION,
    change_1m                DOUBLE PRECISION,
    change_12m               DOUBLE PRECISION,
    average_price_sa         DOUBLE PRECISION,
    sales_volume             DOUBLE PRECISION,
    detached_price           DOUBLE PRECISION,
    detached_index           DOUBLE PRECISION,
    detached1m_change        DOUBLE PRECISION,
    detached12m_change       DOUBLE PRECISION,
    semi_detached_price      DOUBLE PRECISION,
    semi_detached_index      DOUBLE PRECISION,
    semi_detached1m_change   DOUBLE PRECISION,
    semi_detached12m_change  DOUBLE PRECISION,
    terraced_price           DOUBLE PRECISION,
    terraced_index           DOUBLE PRECISION,
    terraced1m_change        DOUBLE PRECISION,
    terraced12m_change       DOUBLE PRECISION,
    flat_price               DOUBLE PRECISION,
    flat_index               DOUBLE PRECISION,
    flat1m_change            DOUBLE PRECISION,
    flat12m_change           DOUBLE PRECISION,
    cash_price               DOUBLE PRECISION,
    cash_index               DOUBLE PRECISION,
    cash1m_change            DOUBLE PRECISION,
    cash12m_change           DOUBLE PRECISION,
    cash_sales_volume        DOUBLE PRECISION,
    mortgage_price           DOUBLE PRECISION,
    mortgage_index           DOUBLE PRECISION,
    mortgage1m_change        DOUBLE PRECISION,
    mortgage12m_change       DOUBLE PRECISION,
    mortgage_salesvolume     DOUBLE PRECISION,
    ftb_price                DOUBLE PRECISION,
    ftb_index                DOUBLE PRECISION,
    ftb1m_change             DOUBLE PRECISION,
    ftb12m_change            DOUBLE PRECISION,
    foo_price                DOUBLE PRECISION,
    foo_index                DOUBLE PRECISION,
    foo1m_change             DOUBLE PRECISION,
    foo12m_change            DOUBLE PRECISION,
    new_price                DOUBLE PRECISION,
    new_index                DOUBLE PRECISION,
    new1m_change             DOUBLE PRECISION,
    new12m_change            DOUBLE PRECISION,
    new_sales_volume         DOUBLE PRECISION,
    old_price                DOUBLE PRECISION,
    old_index                DOUBLE PRECISION,
    old1m_change             DOUBLE PRECISION,
    old12m_change            DOUBLE PRECISION,
    old_sales_volume         DOUBLE PRECISION
) PARTITION BY RANGE (date);

ALTER TABLE house_price_index ADD CONSTRAINT house_price_index_pkey PRIMARY KEY (date, region_name);

CREATE TABLE house_price_index_y1968 PARTITION OF house_price_index
    FOR VALUES FROM ('1968-01-01') TO ('1969-01-01');
CREATE TABLE house_price_index_y1969 PARTITION OF house_price_index
    FOR VALUES FROM ('1969-01-01') TO ('1970-01-01');
CREATE TABLE house_price_index_y1970 PARTITION OF house_price_index
    FOR VALUES FROM ('1970-01-01') TO ('1971-01-01');
CREATE TABLE house_price_index_y1971 PARTITION OF house_price_index
    FOR VALUES FROM ('1971-01-01') TO ('1972-01-01');
CREATE TABLE house_price_index_y1972 PARTITION OF house_price_index
    FOR VALUES FROM ('1972-01-01') TO ('1973-01-01');
CREATE TABLE house_price_index_y1973 PARTITION OF house_price_index
    FOR VALUES FROM ('1973-01-01') TO ('1974-01-01');
CREATE TABLE house_price_index_y1974 PARTITION OF house_price_index
    FOR VALUES FROM ('1974-01-01') TO ('1975-01-01');
CREATE TABLE house_price_index_y1975 PARTITION OF house_price_index
    FOR VALUES FROM ('1975-01-01') TO ('1976-01-01');
CREATE TABLE house_price_index_y1976 PARTITION OF house_price_index
    FOR VALUES FROM ('1976-01-01') TO ('1977-01-01');
CREATE TABLE house_price_index_y1977 PARTITION OF house_price_index
    FOR VALUES FROM ('1977-01-01') TO ('1978-01-01');
CREATE TABLE house_price_index_y1978 PARTITION OF house_price_index
    FOR VALUES FROM ('1978-01-01') TO ('1979-01-01');
CREATE TABLE house_price_index_y1979 PARTITION OF house_price_index
    FOR VALUES FROM ('1979-01-01') TO ('1980-01-01');
CREATE TABLE house_price_index_y1980 PARTITION OF house_price_index
    FOR VALUES FROM ('1980-01-01') TO ('1981-01-01');
CREATE TABLE house_price_index_y1981 PARTITION OF house_price_index
    FOR VALUES FROM ('1981-01-01') TO ('1982-01-01');
CREATE TABLE house_price_index_y1982 PARTITION OF house_price_index
    FOR VALUES FROM ('1982-01-01') TO ('1983-01-01');
CREATE TABLE house_price_index_y1983 PARTITION OF house_price_index
    FOR VALUES FROM ('1983-01-01') TO ('1984-01-01');
CREATE TABLE house_price_index_y1984 PARTITION OF house_price_index
    FOR VALUES FROM ('1984-01-01') TO ('1985-01-01');
CREATE TABLE house_price_index_y1985 PARTITION OF house_price_index
    FOR VALUES FROM ('1985-01-01') TO ('1986-01-01');
CREATE TABLE house_price_index_y1986 PARTITION OF house_price_index
    FOR VALUES FROM ('1986-01-01') TO ('1987-01-01');
CREATE TABLE house_price_index_y1987 PARTITION OF house_price_index
    FOR VALUES FROM ('1987-01-01') TO ('1988-01-01');
CREATE TABLE house_price_index_y1988 PARTITION OF house_price_index
    FOR VALUES FROM ('1988-01-01') TO ('1989-01-01');
CREATE TABLE house_price_index_y1989 PARTITION OF house_price_index
    FOR VALUES FROM ('1989-01-01') TO ('1990-01-01');
CREATE TABLE house_price_index_y1990 PARTITION OF house_price_index
    FOR VALUES FROM ('1990-01-01') TO ('1991-01-01');
CREATE TABLE house_price_index_y1991 PARTITION OF house_price_index
    FOR VALUES FROM ('1991-01-01') TO ('1992-01-01');
CREATE TABLE house_price_index_y1992 PARTITION OF house_price_index
    FOR VALUES FROM ('1992-01-01') TO ('1993-01-01');
CREATE TABLE house_price_index_y1993 PARTITION OF house_price_index
    FOR VALUES FROM ('1993-01-01') TO ('1994-01-01');
CREATE TABLE house_price_index_y1994 PARTITION OF house_price_index
    FOR VALUES FROM ('1994-01-01') TO ('1995-01-01');
CREATE TABLE house_price_index_y1995 PARTITION OF house_price_index
    FOR VALUES FROM ('1995-01-01') TO ('1996-01-01');
CREATE TABLE house_price_index_y1996 PARTITION OF house_price_index
    FOR VALUES FROM ('1996-01-01') TO ('1997-01-01');
CREATE TABLE house_price_index_y1997 PARTITION OF house_price_index
    FOR VALUES FROM ('1997-01-01') TO ('1998-01-01');
CREATE TABLE house_price_index_y1998 PARTITION OF house_price_index
    FOR VALUES FROM ('1998-01-01') TO ('1999-01-01');
CREATE TABLE house_price_index_y1999 PARTITION OF house_price_index
    FOR VALUES FROM ('1999-01-01') TO ('2000-01-01');
CREATE TABLE house_price_index_y2000 PARTITION OF house_price_index
    FOR VALUES FROM ('2000-01-01') TO ('2001-01-01');
CREATE TABLE house_price_index_y2001 PARTITION OF house_price_index
    FOR VALUES FROM ('2001-01-01') TO ('2002-01-01');
CREATE TABLE house_price_index_y2002 PARTITION OF house_price_index
    FOR VALUES FROM ('2002-01-01') TO ('2003-01-01');
CREATE TABLE house_price_index_y2003 PARTITION OF house_price_index
    FOR VALUES FROM ('2003-01-01') TO ('2004-01-01');
CREATE TABLE house_price_index_y2004 PARTITION OF house_price_index
    FOR VALUES FROM ('2004-01-01') TO ('2005-01-01');
CREATE TABLE house_price_index_y2005 PARTITION OF house_price_index
    FOR VALUES FROM ('2005-01-01') TO ('2006-01-01');
CREATE TABLE house_price_index_y2006 PARTITION OF house_price_index
    FOR VALUES FROM ('2006-01-01') TO ('2007-01-01');
CREATE TABLE house_price_index_y2007 PARTITION OF house_price_index
    FOR VALUES FROM ('2007-01-01') TO ('2008-01-01');
CREATE TABLE house_price_index_y2008 PARTITION OF house_price_index
    FOR VALUES FROM ('2008-01-01') TO ('2009-01-01');
CREATE TABLE house_price_index_y2009 PARTITION OF house_price_index
    FOR VALUES FROM ('2009-01-01') TO ('2010-01-01');
CREATE TABLE house_price_index_y2010 PARTITION OF house_price_index
    FOR VALUES FROM ('2010-01-01') TO ('2011-01-01');
CREATE TABLE house_price_index_y2011 PARTITION OF house_price_index
    FOR VALUES FROM ('2011-01-01') TO ('2012-01-01');
CREATE TABLE house_price_index_y2012 PARTITION OF house_price_index
    FOR VALUES FROM ('2012-01-01') TO ('2013-01-01');
CREATE TABLE house_price_index_y2013 PARTITION OF house_price_index
    FOR VALUES FROM ('2013-01-01') TO ('2014-01-01');
CREATE TABLE house_price_index_y2014 PARTITION OF house_price_index
    FOR VALUES FROM ('2014-01-01') TO ('2015-01-01');
CREATE TABLE house_price_index_y2015 PARTITION OF house_price_index
    FOR VALUES FROM ('2015-01-01') TO ('2016-01-01');
CREATE TABLE house_price_index_y2016 PARTITION OF house_price_index
    FOR VALUES FROM ('2016-01-01') TO ('2017-01-01');
CREATE TABLE house_price_index_y2017 PARTITION OF house_price_index
    FOR VALUES FROM ('2017-01-01') TO ('2018-01-01');
CREATE TABLE house_price_index_y2018 PARTITION OF house_price_index
    FOR VALUES FROM ('2018-01-01') TO ('2019-01-01');
CREATE TABLE house_price_index_y2019 PARTITION OF house_price_index
    FOR VALUES FROM ('2019-01-01') TO ('2020-01-01');
CREATE TABLE house_price_index_y2020 PARTITION OF house_price_index
    FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');
CREATE TABLE house_price_index_y2021 PARTITION OF house_price_index
    FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');
CREATE TABLE house_price_index_y2022 PARTITION OF house_price_index
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE INDEX house_price_index_idx ON house_price_index USING btree (date);

-- populate function
CREATE OR REPLACE FUNCTION process_house_price_index_data() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    WITH
        "deleted" as (
            DELETE FROM house_price_index_staging
            RETURNING *
        )
        INSERT INTO house_price_index (
            date, region_name, area_code, average_price, index, index_sa,
            change_1m, change_12m, average_price_sa, sales_volume, detached_price, detached_index,
            detached1m_change, detached12m_change, semi_detached_price, semi_detached_index,
            semi_detached1m_change, semi_detached12m_change, terraced_price, terraced_index,
            terraced1m_change, terraced12m_change, flat_price, flat_index, flat1m_change,
            flat12m_change, cash_price, cash_index, cash1m_change, cash12m_change, cash_sales_volume,
            mortgage_price, mortgage_index, mortgage1m_change, mortgage12m_change, mortgage_salesvolume,
            ftb_price, ftb_index, ftb1m_change, ftb12m_change, foo_price, foo_index, foo1m_change, foo12m_change,
            new_price, new_index, new1m_change, new12m_change, new_sales_volume, old_price, old_index, old1m_change,
            old12m_change, old_sales_volume
        )
        SELECT DISTINCT ON (date, region_name) deleted.*
        FROM deleted
        ORDER BY region_name, date DESC
        ON conflict ON CONSTRAINT "house_price_index_pkey"
        DO UPDATE
                SET area_code                = excluded.area_code
                  , average_price            = excluded.average_price
                  , index                    = excluded.index
                  , index_sa                 = excluded.index_sa
                  , change_1m                = excluded.change_1m
                  , change_12m               = excluded.change_12m
                  , average_price_sa         = excluded.average_price_sa
                  , sales_volume             = excluded.sales_volume
                  , detached_price           = excluded.detached_price
                  , detached_index           = excluded.detached_index
                  , detached1m_change        = excluded.detached1m_change
                  , detached12m_change       = excluded.detached12m_change
                  , semi_detached_price      = excluded.semi_detached_price
                  , semi_detached_index      = excluded.semi_detached_index
                  , semi_detached1m_change   = excluded.semi_detached1m_change
                  , semi_detached12m_change  = excluded.semi_detached12m_change
                  , terraced_price           = excluded.terraced_price
                  , terraced_index           = excluded.terraced_index
                  , terraced1m_change        = excluded.terraced1m_change
                  , terraced12m_change       = excluded.terraced12m_change
                  , flat_price               = excluded.flat_price
                  , flat_index               = excluded.flat_index
                  , flat1m_change            = excluded.flat1m_change
                  , flat12m_change           = excluded.flat12m_change
                  , cash_price               = excluded.cash_price
                  , cash_index               = excluded.cash_index
                  , cash1m_change            = excluded.cash1m_change
                  , cash12m_change           = excluded.cash12m_change
                  , cash_sales_volume        = excluded.cash_sales_volume
                  , mortgage_price           = excluded.mortgage_price
                  , mortgage_index           = excluded.mortgage_index
                  , mortgage1m_change        = excluded.mortgage1m_change
                  , mortgage12m_change       = excluded.mortgage12m_change
                  , mortgage_salesvolume     = excluded.mortgage_salesvolume
                  , ftb_price                = excluded.ftb_price
                  , ftb_index                = excluded.ftb_index
                  , ftb1m_change             = excluded.ftb1m_change
                  , ftb12m_change            = excluded.ftb12m_change
                  , foo_price                = excluded.foo_price
                  , foo_index                = excluded.foo_index
                  , foo1m_change             = excluded.foo1m_change
                  , foo12m_change            = excluded.foo12m_change
                  , new_price                = excluded.new_price
                  , new_index                = excluded.new_index
                  , new1m_change             = excluded.new1m_change
                  , new12m_change            = excluded.new12m_change
                  , new_sales_volume         = excluded.new_sales_volume
                  , old_price                = excluded.old_price
                  , old_index                = excluded.old_index
                  , old1m_change             = excluded.old1m_change
                  , old12m_change            = excluded.old12m_change
                  , old_sales_volume         = excluded.old_sales_volume
        WHERE excluded IS DISTINCT FROM house_price_index;
END;
$$;


-- There is room for enhancement here, this should be moved to be calculated in the database on fly in process function
-- decision here to be done in this way since the input files where always contains historical data, which it might contain
-- missing data from past, so it is better to have a consistent way of calculating the results

CREATE OR REPLACE FUNCTION calc_yearly_avg_price() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    TRUNCATE yearly_avg_price;

    INSERT INTO yearly_avg_price (date_year, average_price)
    SELECT date_year, AVG(average_price) AS average_price
    FROM house_price_index
    GROUP BY date_year;
END;
$$;

CREATE OR REPLACE FUNCTION calc_region_price_gain() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    TRUNCATE region_price_gain;

    INSERT INTO region_price_gain (region_name, first_date, first_price, last_date, last_price, price_gain)
    WITH aggregated AS (
        SELECT DISTINCT ON (region_name) region_name
             , date AS first_date
             , average_price AS first_price
             , first_value(date) OVER w AS last_date
             , first_value(average_price) OVER w AS last_price
          FROM house_price_index
        WINDOW w AS (PARTITION BY region_name ORDER BY date DESC)
        ORDER BY region_name, date
    )
    SELECT *, (last_price - first_price) AS price_gain
    FROM aggregated;
END;
$$;

COMMIT;