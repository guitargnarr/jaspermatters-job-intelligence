import { test, expect, devices } from '@playwright/test';

const PROD_URL = 'https://jaspermatters-job-intelligence.vercel.app';

test.describe('Jaspermatters - Core Functionality', () => {
  test('Page loads successfully', async ({ page }) => {
    const response = await page.goto(PROD_URL);
    expect(response?.status()).toBe(200);
  });

  test('Title is present', async ({ page }) => {
    await page.goto(PROD_URL);
    const title = await page.title();
    expect(title.length).toBeGreaterThan(0);
  });

  test('Main heading visible', async ({ page }) => {
    await page.goto(PROD_URL);
    await page.waitForLoadState('networkidle');
    const h1 = page.locator('h1');
    await expect(h1.first()).toBeVisible();
  });

  test('Navigation present', async ({ page }) => {
    await page.goto(PROD_URL);
    await page.waitForLoadState('networkidle');
    const nav = page.locator('nav');
    await expect(nav.first()).toBeVisible();
  });

  test('Platform demo section present', async ({ page }) => {
    await page.goto(PROD_URL);
    await page.waitForLoadState('networkidle');
    const platform = page.locator('#platform');
    await expect(platform).toBeAttached();
  });
});

test.describe('Jaspermatters - Content', () => {
  test('AI/ML related content visible', async ({ page }) => {
    await page.goto(PROD_URL);
    await page.waitForLoadState('networkidle');
    const content = page.locator('text=/ML|AI|Machine Learning|Model|TensorFlow/i');
    const count = await content.count();
    expect(count).toBeGreaterThan(0);
  });

  test('Interactive elements present', async ({ page }) => {
    await page.goto(PROD_URL);
    await page.waitForLoadState('networkidle');
    const interactiveElements = page.locator('a, button');
    const count = await interactiveElements.count();
    expect(count).toBeGreaterThan(0);
  });
});

test.describe('Jaspermatters - SEO & Meta Tags', () => {
  test('Meta description present', async ({ page }) => {
    await page.goto(PROD_URL);
    const metaDesc = page.locator('meta[name="description"]');
    await expect(metaDesc).toBeAttached();
  });

  test('OG image present', async ({ page }) => {
    await page.goto(PROD_URL);
    const ogImage = page.locator('meta[property="og:image"]');
    await expect(ogImage).toBeAttached();
  });

  test('Viewport meta present', async ({ page }) => {
    await page.goto(PROD_URL);
    const viewport = page.locator('meta[name="viewport"]');
    await expect(viewport).toBeAttached();
  });
});

test.describe('Jaspermatters - Mobile Responsiveness', () => {
  test('No horizontal overflow on mobile', async ({ browser }) => {
    const context = await browser.newContext({ ...devices['iPhone 12'] });
    const page = await context.newPage();
    await page.goto(PROD_URL);
    await page.waitForLoadState('networkidle');

    const hasOverflow = await page.evaluate(() => {
      return document.body.scrollWidth > document.documentElement.clientWidth;
    });
    expect(hasOverflow).toBe(false);
    await context.close();
  });

  test('Touch targets meet 44px minimum', async ({ browser }) => {
    const context = await browser.newContext({ ...devices['iPhone 12'] });
    const page = await context.newPage();
    await page.goto(PROD_URL);
    await page.waitForLoadState('networkidle');

    const smallTargets = await page.evaluate(() => {
      const elements = [...document.querySelectorAll('a, button')];
      return elements.filter(el => {
        const rect = el.getBoundingClientRect();
        // Skip hidden elements and sr-only
        const computedStyle = window.getComputedStyle(el);
        if (computedStyle.display === 'none' || computedStyle.visibility === 'hidden') return false;
        const isSrOnly = computedStyle.position === 'absolute' &&
                         (rect.width <= 1 || rect.height <= 1);
        if (isSrOnly) return false;
        return rect.width > 0 && rect.height > 0 && (rect.width < 43.5 || rect.height < 43.5);
      }).map(el => ({
        text: el.textContent?.slice(0, 30),
        width: Math.round(el.getBoundingClientRect().width),
        height: Math.round(el.getBoundingClientRect().height),
        classes: el.className?.slice(0, 50)
      }));
    });

    console.log('Small touch targets found:', JSON.stringify(smallTargets, null, 2));
    expect(smallTargets).toHaveLength(0);
    await context.close();
  });

  test('Content accessible on mobile', async ({ browser }) => {
    const context = await browser.newContext({ ...devices['iPhone 12'] });
    const page = await context.newPage();
    await page.goto(PROD_URL);
    await page.waitForLoadState('networkidle');

    const mainContent = page.locator('h1, main, section');
    await expect(mainContent.first()).toBeVisible();
    await context.close();
  });
});

test.describe('Jaspermatters - Accessibility', () => {
  test('Interactive elements are focusable', async ({ page }) => {
    await page.goto(PROD_URL);
    await page.waitForLoadState('networkidle');

    await page.keyboard.press('Tab');

    const focused = page.locator(':focus');
    await expect(focused).toBeVisible();
  });

  test('Links have accessible names', async ({ page }) => {
    await page.goto(PROD_URL);
    await page.waitForLoadState('networkidle');

    const links = page.locator('a');
    const count = await links.count();

    for (let i = 0; i < Math.min(count, 5); i++) {
      const link = links.nth(i);
      const text = await link.textContent();
      const ariaLabel = await link.getAttribute('aria-label');
      const title = await link.getAttribute('title');

      expect(text || ariaLabel || title).toBeTruthy();
    }
  });
});
