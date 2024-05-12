import cdsapi
from cassandra.cluster import Cluster
import xarray as xr
import pandas as pd

def ingest_data():
    file_path = './new_data.nc'
    c = cdsapi.Client()

    c.retrieve(
        'reanalysis-era5-single-levels-monthly-means',
        {
            'product_type': 'monthly_averaged_reanalysis_by_hour_of_day',
            'variable': [
            '10m_u_component_of_wind', '10m_v_component_of_wind', '2m_dewpoint_temperature',
            '2m_temperature', 'clear_sky_direct_solar_radiation_at_surface', 'convective_precipitation',
            'evaporation', 'high_cloud_cover', 'high_vegetation_cover',
            'leaf_area_index_high_vegetation', 'leaf_area_index_low_vegetation', 'low_cloud_cover',
            'low_vegetation_cover', 'mean_sea_level_pressure', 'mean_surface_direct_short_wave_radiation_flux',
            'mean_surface_direct_short_wave_radiation_flux_clear_sky', 'mean_surface_downward_long_wave_radiation_flux', 'mean_surface_downward_long_wave_radiation_flux_clear_sky',
            'mean_surface_downward_short_wave_radiation_flux', 'mean_surface_downward_short_wave_radiation_flux_clear_sky', 'mean_surface_downward_uv_radiation_flux',
            'mean_surface_latent_heat_flux', 'mean_surface_net_long_wave_radiation_flux', 'mean_surface_net_long_wave_radiation_flux_clear_sky',
            'mean_surface_net_short_wave_radiation_flux', 'mean_surface_net_short_wave_radiation_flux_clear_sky', 'mean_surface_runoff_rate',
            'mean_surface_sensible_heat_flux', 'mean_top_downward_short_wave_radiation_flux', 'mean_top_net_long_wave_radiation_flux',
            'mean_top_net_long_wave_radiation_flux_clear_sky', 'mean_top_net_short_wave_radiation_flux', 'mean_top_net_short_wave_radiation_flux_clear_sky',
            'mean_wave_direction', 'mean_wave_period', 'medium_cloud_cover',
            'peak_wave_period', 'sea_ice_cover', 'sea_surface_temperature',
            'significant_height_of_combined_wind_waves_and_swell', 'sub_surface_runoff', 'surface_net_solar_radiation',
            'surface_net_solar_radiation_clear_sky', 'surface_pressure', 'surface_runoff',
            'surface_solar_radiation_downward_clear_sky', 'surface_solar_radiation_downwards', 'top_net_solar_radiation',
            'top_net_solar_radiation_clear_sky', 'total_cloud_cover', 'total_precipitation',
            'total_sky_direct_solar_radiation_at_surface', 'type_of_high_vegetation', 'type_of_low_vegetation',
        ],
            'year': [
                '2023',
                '2024',
            ],
            'month': [
                '01'
            ],
            'time': [
                '18:00'
            ],
            'area': [
                5, 120, -5,
                170,
            ],
            'format': 'netcdf',
        },
        file_path)

    dataset = xr.open_dataset(file_path)
    dataset_df = dataset.to_dataframe().reset_index()
    dataset_df["time"] = pd.to_datetime(dataset_df["time"])


    cluster = Cluster(['cassandra'])
    session = cluster.connect('cds_data')
    execute_query(dataset_df.sample(20), session)


def execute_query(df, session):
    insert_stmt = session.prepare("""
    INSERT INTO era5_raw (
        time, latitude, longitude, u10, v10, d2m, t2m, cdir, cp, e, hcc, cvh, lai_hv, lai_lv, lcc, cvl,
        msl, msdrswrf, msdrswrfcs, msdwlwrf, msdwlwrfcs, msdwswrf, msdwswrfcs, msdwuvrf, mslhf, msnlwrf, 
        msnlwrfcs, msnswrf, msnswrfcs, msror, msshf, mtdwswrf, mtnlwrf, mtnlwrfcs, mtnswrf, mtnswrfcs, mwd, mwp, 
        mcc, pp1d, siconc, sst, swh, ssro, ssr, ssrc, sp, sro, ssrdc, ssrd, tsr, tsrc, tcc, tp, fdir, tvh, tvl
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
""")

# Assume 'df' is your DataFrame
    for index, row in df.iterrows():
        try:
            values = [
                row['time'].to_pydatetime() if pd.notna(row['time']) else None,
                float(row['latitude']) if pd.notna(row['latitude']) else None,
                float(row['longitude']) if pd.notna(row['longitude']) else None,
                float(row['u10']) if pd.notna(row['u10']) else None,
                float(row['v10']) if pd.notna(row['v10']) else None,
                float(row['d2m']) if pd.notna(row['d2m']) else None,
                float(row['t2m']) if pd.notna(row['t2m']) else None,
                float(row['cdir']) if pd.notna(row['cdir']) else None,
                float(row['cp']) if pd.notna(row['cp']) else None,
                float(row['e']) if pd.notna(row['e']) else None,
                float(row['hcc']) if pd.notna(row['hcc']) else None,
                float(row['cvh']) if pd.notna(row['cvh']) else None,
                float(row['lai_hv']) if pd.notna(row['lai_hv']) else None,
                float(row['lai_lv']) if pd.notna(row['lai_lv']) else None,
                float(row['lcc']) if pd.notna(row['lcc']) else None,
                float(row['cvl']) if pd.notna(row['cvl']) else None,
                float(row['msl']) if pd.notna(row['msl']) else None,
                float(row['msdrswrf']) if pd.notna(row['msdrswrf']) else None,
                float(row['msdrswrfcs']) if pd.notna(row['msdrswrfcs']) else None,
                float(row['msdwlwrf']) if pd.notna(row['msdwlwrf']) else None,
                float(row['msdwlwrfcs']) if pd.notna(row['msdwlwrfcs']) else None,
                float(row['msdwswrf']) if pd.notna(row['msdwswrf']) else None,
                float(row['msdwswrfcs']) if pd.notna(row['msdwswrfcs']) else None,
                float(row['msdwuvrf']) if pd.notna(row['msdwuvrf']) else None,
                float(row['mslhf']) if pd.notna(row['mslhf']) else None,
                float(row['msnlwrf']) if pd.notna(row['msnlwrf']) else None,
                float(row['msnlwrfcs']) if pd.notna(row['msnlwrfcs']) else None,
                float(row['msnswrf']) if pd.notna(row['msnswrf']) else None,
                float(row['msnswrfcs']) if pd.notna(row['msnswrfcs']) else None,
                float(row['msror']) if pd.notna(row['msror']) else None,
                float(row['msshf']) if pd.notna(row['msshf']) else None,
                float(row['mtdwswrf']) if pd.notna(row['mtdwswrf']) else None,
                float(row['mtnlwrf']) if pd.notna(row['mtnlwrf']) else None,
                float(row['mtnlwrfcs']) if pd.notna(row['mtnlwrfcs']) else None,
                float(row['mtnswrf']) if pd.notna(row['mtnswrf']) else None,
                float(row['mtnswrfcs']) if pd.notna(row['mtnswrfcs']) else None,
                float(row['mwd']) if pd.notna(row['mwd']) else None,
                float(row['mwp']) if pd.notna(row['mwp']) else None,
                float(row['mcc']) if pd.notna(row['mcc']) else None,
                float(row['pp1d']) if pd.notna(row['pp1d']) else None,
                float(row['siconc']) if pd.notna(row['siconc']) else None,
                float(row['sst']) if pd.notna(row['sst']) else None,
                float(row['swh']) if pd.notna(row['swh']) else None,
                float(row['ssro']) if pd.notna(row['ssro']) else None,
                float(row['ssr']) if pd.notna(row['ssr']) else None,
                float(row['ssrc']) if pd.notna(row['ssrc']) else None,
                float(row['sp']) if pd.notna(row['sp']) else None,
                float(row['sro']) if pd.notna(row['sro']) else None,
                float(row['ssrdc']) if pd.notna(row['ssrdc']) else None,
                float(row['ssrd']) if pd.notna(row['ssrd']) else None,
                float(row['tsr']) if pd.notna(row['tsr']) else None,
                float(row['tsrc']) if pd.notna(row['tsrc']) else None,
                float(row['tcc']) if pd.notna(row['tcc']) else None,
                float(row['tp']) if pd.notna(row['tp']) else None,
                float(row['fdir']) if pd.notna(row['fdir']) else None,
                float(row['tvh']) if pd.notna(row['tvh']) else None,
                float(row['tvl']) if pd.notna(row['tvl']) else None
            ]
            session.execute(insert_stmt, values)
        except Exception as e:
            print(f"Failed to insert data for row {index}: {e}")

    print("SUCCESS : Data pushed successfully!")

if __name__ == "__main__":
    ingest_data()

