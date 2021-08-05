module.exports = {
    docs: [{
            type: 'category',
            label: 'Tools',
            collapsed: true,
            items: [
                'docs/tools/aws',
                'docs/tools/docker',
                'docs/tools/git',
                'docs/tools/kubernetes',
                'docs/tools/postgis',
                'docs/tools/postgres',
                'docs/tools/unix',
                {
                    type: 'category',
                    label: 'Misc',
                    items: [
                        'docs/tools/android',
                        'docs/tools/apache2',
                        'docs/tools/caddy',
                        'docs/tools/ffmpeg',
                        'docs/tools/fish',
                        'docs/tools/osx',
                        'docs/tools/pandoc',
                        'docs/tools/youtube-dl',
                    ]
                }
            ],
        },
        {
            type: 'category',
            label: 'Data Science',
            collapsed: false,
            items: [
                'docs/data-science/dvc',
                'docs/data-science/jupyter',
                'docs/data-science/numpy',
                'docs/data-science/pandas',
                'docs/data-science/pyspark',
                'docs/data-science/sklearn',
                'docs/data-science/visualizations',
                {
                    type: 'category',
                    label: 'GIS',
                    items: [
                        'docs/data-science/gis/folium',
                        'docs/data-science/gis/geopandas',
                        'docs/data-science/gis/shapely',
                        'docs/data-science/gis/gdal',
                        'docs/data-science/gis/references',
                    ]
                },
                {
                    type: 'category',
                    label: 'Web Scraping',
                    items: [
                        'docs/data-science/web-scraping/requests',
                        'docs/data-science/web-scraping/scrapy',
                        'docs/data-science/web-scraping/selenium',
                        'docs/data-science/web-scraping/references',
                    ]
                },
            ]
        },
        {
            type: 'category',
            label: 'Python',
            items: [
                'docs/python/environment',
                'docs/python/modules',
                'docs/python/built-in-modules',
                'docs/python/database',
                'docs/python/pdf',
                'docs/python/termcolor',
                'docs/python/tqdm',
            ]
        },
        'docs/misc'
    ],
    knowledgeBase: [{
            type: 'category',
            label: 'Resources',
            collapsed: false,
            items: [
                'knowledge-base/resources/data-science',
                'knowledge-base/resources/devops',
                'knowledge-base/resources/data',
                'knowledge-base/resources/misc',
            ]
        },
        'knowledge-base/etl-saas-intel',
        'knowledge-base/celiac',
        'knowledge-base/languages',
        'knowledge-base/repair-shops',
        'knowledge-base/shopping',
        'knowledge-base/utilities',
    ],
    projects: [
        {
            type: 'category',
            label: 'Career',
            items: [
                'projects/career/one-on-one',
                'projects/career/career-path',
            ]
        }
    ],
    recipes: [{
        type: 'category',
        label: 'Menu',
        items: [
            'recipes/easy',
            'recipes/food',
        ]
    }],
    languagues: [
        'languages/russian',
        'languages/thai',
    ]
};
