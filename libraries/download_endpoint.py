import os
import requests


def download_csv(endpoint, output_path):
    req = requests.get(endpoint)
    url_content = req.content
    csv_file = open(output_path, 'wb')

    csv_file.write(url_content)
    csv_file.close()
