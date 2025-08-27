#!/bin/bash

# Automated DNS Fix Script for jaspermatters.com
# This script monitors and updates DNS once you switch nameservers

echo "🚀 DNS Migration Assistant for jaspermatters.com"
echo "================================================"
echo ""
echo "📋 MANUAL STEP REQUIRED (You must do this):"
echo ""
echo "1. In Render tab: Click 'ourjourney-api' → Settings → Custom Domains → Remove jaspermatters.com"
echo "2. In GoDaddy tab: Click 'Change' → Select 'GoDaddy Nameservers' → Save"
echo ""
echo "Press ENTER when you've completed these steps..."
read

echo ""
echo "⏳ Checking nameserver propagation..."

# Function to check nameservers
check_nameservers() {
    ns=$(nslookup -type=NS jaspermatters.com 2>/dev/null | grep "nameserver" | head -1)
    if echo "$ns" | grep -q "godaddy.com"; then
        return 0
    else
        return 1
    fi
}

# Wait for nameserver change
attempts=0
max_attempts=60  # 30 minutes max

while [ $attempts -lt $max_attempts ]; do
    if check_nameservers; then
        echo "✅ Nameservers switched to GoDaddy!"
        break
    else
        echo "⏳ Waiting for nameserver change... (attempt $((attempts + 1))/$max_attempts)"
        sleep 30
        attempts=$((attempts + 1))
    fi
done

if [ $attempts -eq $max_attempts ]; then
    echo "❌ Timeout waiting for nameserver change. Please check GoDaddy manually."
    exit 1
fi

echo ""
echo "📝 Next Steps (Manual):"
echo ""
echo "1. Go to GoDaddy DNS Records tab (should now be accessible)"
echo "2. Add these A records:"
echo "   Type: A    Name: @    Value: 185.199.108.153"
echo "   Type: A    Name: @    Value: 185.199.109.153"
echo "   Type: A    Name: @    Value: 185.199.110.153"
echo "   Type: A    Name: @    Value: 185.199.111.153"
echo ""
echo "3. Add this CNAME:"
echo "   Type: CNAME    Name: www    Value: guitargnar.github.io"
echo ""
echo "Press ENTER when DNS records are added..."
read

echo ""
echo "🔍 Verifying DNS configuration..."
sleep 10

# Check if DNS points to GitHub
check_github_dns() {
    ips=$(nslookup jaspermatters.com 2>/dev/null | grep "Address" | grep -v "#" | awk '{print $2}')
    for ip in $ips; do
        if echo "$ip" | grep -q "185.199"; then
            return 0
        fi
    done
    return 1
}

# Monitor DNS propagation
attempts=0
while [ $attempts -lt 60 ]; do
    if check_github_dns; then
        echo "✅ DNS is pointing to GitHub Pages!"
        break
    else
        echo "⏳ Waiting for DNS propagation... (attempt $((attempts + 1))/60)"
        sleep 30
        attempts=$((attempts + 1))
    fi
done

echo ""
echo "🎉 SUCCESS! DNS migration complete!"
echo ""
echo "📍 Final Steps:"
echo "1. Go to: https://github.com/guitargnar/jaspermatters-job-intelligence/settings/pages"
echo "2. Click 'Check again' next to DNS error"
echo "3. Enable 'Enforce HTTPS'"
echo ""
echo "Your ML platform will be live at https://jaspermatters.com in 5-10 minutes!"
echo ""
echo "🧪 Test your site:"
echo "   https://jaspermatters.com (Landing page)"
echo "   https://jaspermatters.com/resume.html (Resume)"

# Open the sites
sleep 300  # Wait 5 minutes for deployment
open "https://jaspermatters.com"
open "https://github.com/guitargnar/jaspermatters-job-intelligence/settings/pages"