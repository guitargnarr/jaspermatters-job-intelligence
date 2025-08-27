#!/bin/bash

# Deployment Verification Script for jaspermatters.com
# This script checks if your GitHub Pages deployment is working

echo "🔍 Checking deployment status for jaspermatters.com..."
echo ""

# Check if GitHub Pages is accessible
echo "1️⃣ Checking GitHub Pages URL..."
if curl -s -o /dev/null -w "%{http_code}" https://guitargnar.github.io/jaspermatters-job-intelligence | grep -q "200\|301\|302"; then
    echo "✅ GitHub Pages is active!"
    echo "   URL: https://guitargnar.github.io/jaspermatters-job-intelligence"
else
    echo "⏳ GitHub Pages not yet active (this can take 10-20 minutes)"
fi
echo ""

# Check DNS for jaspermatters.com
echo "2️⃣ Checking DNS configuration..."
DNS_CHECK=$(nslookup jaspermatters.com 2>/dev/null | grep -E "185.199.(108|109|110|111).153")
if [ ! -z "$DNS_CHECK" ]; then
    echo "✅ DNS is configured correctly!"
    echo "   A records point to GitHub Pages"
else
    echo "⏳ DNS not yet configured or propagating"
    echo "   Add these A records at your registrar:"
    echo "   185.199.108.153"
    echo "   185.199.109.153"
    echo "   185.199.110.153"
    echo "   185.199.111.153"
fi
echo ""

# Check if jaspermatters.com is accessible
echo "3️⃣ Checking jaspermatters.com..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://jaspermatters.com 2>/dev/null)
if [ "$HTTP_STATUS" = "200" ]; then
    echo "✅ jaspermatters.com is LIVE!"
    echo "   Your Job Intelligence Platform is running!"
elif [ "$HTTP_STATUS" = "301" ] || [ "$HTTP_STATUS" = "302" ]; then
    echo "✅ jaspermatters.com is redirecting (HTTPS working)"
else
    echo "⏳ jaspermatters.com not yet accessible (DNS propagating)"
    echo "   HTTP Status: $HTTP_STATUS"
fi
echo ""

# Check specific pages
echo "4️⃣ Checking site pages..."
if [ "$HTTP_STATUS" = "200" ]; then
    # Check landing page
    if curl -s https://jaspermatters.com | grep -q "Job Intelligence Platform"; then
        echo "✅ Landing page is working"
    fi
    
    # Check resume page
    if curl -s https://jaspermatters.com/resume.html | grep -q "Matthew Scott"; then
        echo "✅ Resume page is working"
    fi
else
    echo "⏳ Pages will be checked once domain is accessible"
fi
echo ""

# Summary
echo "📊 DEPLOYMENT SUMMARY"
echo "════════════════════════════════════════"
if [ "$HTTP_STATUS" = "200" ]; then
    echo "🎉 SUCCESS! Your site is live at jaspermatters.com"
    echo ""
    echo "Share your portfolio:"
    echo "• Landing: https://jaspermatters.com"
    echo "• Resume: https://jaspermatters.com/resume.html"
    echo "• GitHub: https://github.com/guitargnar/jaspermatters-job-intelligence"
else
    echo "⏳ PENDING: Deployment in progress..."
    echo ""
    echo "Next steps:"
    echo "1. Complete GitHub Pages setup in browser (if not done)"
    echo "2. Configure DNS at your domain registrar"
    echo "3. Wait 10-30 minutes for propagation"
    echo "4. Run this script again: ./verify_deployment.sh"
fi
echo "════════════════════════════════════════"