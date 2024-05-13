-- This script assumes you are connected to the default or an existing database to check other databases
-- Create the required table in the target database (which is created via Docker's ENV variables)

-- Connect to the specified database (handled by Docker environment)
\c result_data

-- Check if the table exists and create it if it does not
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_tables WHERE schemaname = 'public' AND tablename = 'sst_era5') THEN
        CREATE TABLE public.sst_era5 (
            id SERIAL PRIMARY KEY,
            time TIMESTAMP,
            sst FLOAT,
            latitude FLOAT,
            longitude FLOAT,
            "95_lower_bound_CI" FLOAT,
            "95_upper_bound_CI" FLOAT,
            "99_lower_bound_CI" FLOAT,
            "99_upper_bound_CI" FLOAT
        );
    END IF;
END $$;
