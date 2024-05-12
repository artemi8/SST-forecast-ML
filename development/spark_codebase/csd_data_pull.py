import cdsapi

c = cdsapi.Client()

c.retrieve(
    'reanalysis-era5-single-levels-monthly-means',
    {
        'product_type': 'monthly_averaged_reanalysis_by_hour_of_day',
        'variable': [
            'longitude', 'latitude', 'time', '10 metre U wind component',
            '10 metre V wind component', '2 metre dewpoint temperature', '2 metre temperature',
              'Convective precipitation', 'Evaporation', 'High cloud cover', 
              'High vegetation cover', 'Leaf area index, high vegetation', 
              'Leaf area index, low vegetation', 'Low cloud cover', 'Low vegetation cover', 
              'Mean sea level pressure', 'Mean surface downward long-wave radiation flux', 
              'Mean surface downward long-wave radiation flux, clear sky', 
              'Mean surface latent heat flux', 'Mean surface net long-wave radiation flux', 
              'Mean surface net long-wave radiation flux, clear sky', 'Mean surface runoff rate',
                'Mean surface sensible heat flux', 'Mean top net long-wave radiation flux',
                  'Mean top net long-wave radiation flux, clear sky', 'Medium cloud cover',
                    'Sea ice area fraction', 'Sea surface temperature', 'Sub-surface runoff',
                      'Surface pressure', 'Surface runoff', 'Total cloud cover',
                        'Total precipitation', 'Type of high vegetation', 'Type of low vegetation'
                        ],
        'year': [
            '2023',
        ],
        'month': [
            '01', '02',
        ],
        'time': [
            '18:00',
        ],
        'area': [
            5, 120, -5,
            170,
        ],
        'format': 'netcdf',
    },
    'test.nc')