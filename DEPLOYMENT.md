# 🚀 Deployment Guide - View on Your iPad!

This guide will help you deploy the Lexicon Reader app to GitHub Pages so you can view it in Safari on your iPad.

## 📱 Quick Setup (5 minutes)

### Step 1: Enable GitHub Pages

1. Go to your repository: https://github.com/Ayabara1013/lexicon-reader
2. Click **Settings** (top menu)
3. In the left sidebar, click **Pages** (under "Code and automation")
4. Under "Build and deployment":
   - **Source**: Select "GitHub Actions"
5. Click **Save**

That's it! GitHub Pages is now enabled.

### Step 2: Merge Your Branch

The GitHub Action will automatically run when code is pushed to the `main` or `master` branch:

```bash
# Option A: Merge via Pull Request (Recommended)
# 1. Go to GitHub
# 2. Create a Pull Request from claude/review-reddit-project-CunG4 to main
# 3. Merge the PR

# Option B: Merge via command line
git checkout main
git merge claude/review-reddit-project-CunG4
git push origin main
```

### Step 3: Wait for Deployment (2-3 minutes)

1. Go to the **Actions** tab in your GitHub repo
2. You'll see a workflow running called "Deploy Flutter Web to GitHub Pages"
3. Wait for it to complete (green checkmark ✓)

### Step 4: Open on Your iPad! 🎉

Once deployment is complete, open Safari on your iPad and go to:

```
https://ayabara1013.github.io/lexicon-reader/
```

**Bookmark it** or **Add to Home Screen** for easy access!

## 📲 Add to iPad Home Screen (Optional but Cool!)

For the best experience, add the app to your iPad home screen:

1. Open the app URL in Safari
2. Tap the **Share** button (square with arrow)
3. Scroll down and tap **Add to Home Screen**
4. Tap **Add**

Now you'll have a synthwave app icon on your home screen! 🌃

## ✨ What to Expect

When you open the app on your iPad, you'll see:

- ✅ **Synthwave theme** with neon colors
- ✅ **Smooth animations** and glowing effects
- ✅ **Touch gestures** working perfectly
- ✅ **Responsive layout** optimized for tablets
- ✅ **All features** working (library, reader, settings)
- ✅ **Reading customization** with sliders and toggles

## 🔧 Troubleshooting

### "Page not found" error
- Wait a few more minutes - deployment can take 3-5 minutes
- Check the Actions tab to ensure deployment succeeded

### Deployment failed
- Check the Actions tab for error messages
- The most common issue is Flutter version - the workflow uses Flutter 3.24.0

### App looks wrong
- Clear Safari cache: Settings → Safari → Clear History and Website Data
- Force reload: Hold refresh button and select "Reload Without Content Blockers"

## 🔄 Updating the App

After making changes to the code:

1. Commit and push to the `main` branch
2. GitHub Actions will automatically rebuild and deploy
3. Wait 2-3 minutes
4. Refresh the page on your iPad (may need to clear cache)

## 🎨 Custom Domain (Optional)

Want a custom domain like `lexicon.yourdomain.com`?

1. Go to Settings → Pages
2. Under "Custom domain", enter your domain
3. Follow the DNS configuration instructions
4. Update `--base-href` in `.github/workflows/deploy.yml` to `/`

## 📊 Deployment Status

Check deployment status at any time:
- **Actions tab**: https://github.com/Ayabara1013/lexicon-reader/actions
- **Deployments**: Look for the "github-pages" environment

## ⚡ Performance Tips for iPad

The app is already optimized, but for best performance:
- Use Safari (best Flutter web support on iOS)
- Enable "Request Desktop Website" for larger layout
- Close other apps to free up memory
- Use landscape mode for better reading experience

---

**Once deployed, you'll be able to:**
- ✨ View the app on any device with a browser
- 📱 Test on your iPad in Safari
- 🔗 Share the link with others
- 💾 Add to home screen for app-like experience

Happy reading in the neon-lit cyberpunk world! 🌃💜
