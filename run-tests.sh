#!/bin/bash
# Script para ejecutar tests del Facturador Pro 6
# Uso: ./run-tests.sh [suite]

SUITE=${1:-all}

echo "=== Facturador Pro 6 - Test Runner ==="
echo ""

case $SUITE in
    all)
        echo "Ejecutando todas las suites..."
        vendor/bin/phpunit --verbose --colors
        ;;
    core)
        echo "Ejecutando tests del CoreFacturalo..."
        vendor/bin/phpunit --testsuite CoreFacturalo --verbose --colors
        ;;
    unit)
        echo "Ejecutando tests unitarios..."
        vendor/bin/phpunit --testsuite Unit --verbose --colors
        ;;
    feature)
        echo "Ejecutando tests de funcionalidad..."
        vendor/bin/phpunit --testsuite Feature --verbose --colors
        ;;
    coverage)
        echo "Ejecutando tests con cobertura..."
        vendor/bin/phpunit --coverage-html tests/report --colors
        echo "Reporte generado en tests/report/index.html"
        ;;
    *)
        echo "Uso: ./run-tests.sh [all|core|unit|feature|coverage]"
        exit 1
        ;;
esac
