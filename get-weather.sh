#!/usr/bin/env bash

# Este script ejecuta un bloque Python directamente
python3 << EOF
import requests
import csv
import os
from datetime import datetime

API_KEY = "d1c4a716585212f0d95f61e72dafe4c4"  
LAT = "41.3888"  # Latitud de Barcelona
LON = "2.159"  # Longitud de Barcelona
CITY = "Barcelona"

url = f"http://api.openweathermap.org/data/2.5/weather?lat={LAT}&lon={LON}&appid={API_KEY}&units=metric"

# Nombre del archivo CSV
filename = f"/root/Proyecto/clima-{CITY}-hoy.csv"

try:
    # Obtener los datos de la API
    response = requests.get(url)
    response.raise_for_status()
    data = response.json()

    # Extraer datos
    temp = data["main"]["temp"]
    pressure = data["main"]["pressure"]
    humidity = data["main"]["humidity"]
    wind_speed = data["wind"]["speed"]
    weather_desc = data["weather"][0]["description"]

    # Verificar si hay lluvia o nieve
    rain = data.get("rain", {}).get("1h", 0)  # Lluvia en 1h (si existe)
    snow = data.get("snow", {}).get("1h", 0)  # Nieve en 1h (si existe)

    # Obtener la hora actual
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Escribir en el CSV
    file_exists = os.path.isfile(filename)
    with open(filename, mode="a", newline="") as file:
        writer = csv.writer(file)

        # Escribir la cabecera solo si el archivo es nuevo
        if not file_exists:
            writer.writerow(["Timestamp", "Temperature", "Pressure", "Humidity", "Wind Speed", "Description", "Rain (mm)", "Snow (mm)"])

        # Escribir los datos
        writer.writerow([timestamp, temp, pressure, humidity, wind_speed, weather_desc, rain, snow])

    print(f"Datos guardados en {filename}")

except requests.exceptions.RequestException as e:
    print("Error al obtener los datos del clima:", e)
EOF

