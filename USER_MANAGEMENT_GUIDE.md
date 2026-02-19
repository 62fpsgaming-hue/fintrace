# User Management System Guide

This guide explains the enhanced user management system implemented in the RIFT fraud detection dashboard.

## Overview

The user management system provides:
- User authentication (sign up, sign in, sign out)
- User profiles with customizable information
- User settings and preferences
- Analysis history with favorites, tags, and notes
- Activity logging
- Saved filters for quick analysis
- Analysis sharing capabilities

## Features

### 1. Authentication Flow

Users can sign up and sign in through the authentication pages:
- `/auth/sign-up` - Create a new account
- `/auth/login` - Sign in to existing account
- After successful authentication, users are redirected to `/dashboard`

### 2. User Profile

Access via the user menu dropdown in the dashboard header or directly at `/profile`.

The profile page has three tabs:

#### Profile Tab
- View and edit user information (name, email, bio, location, website)
- Upload profile avatar (coming soon)
- View account creation date
- Account management options

#### Settings Tab
- Email notifications preferences
- Analysis preferences (auto-save, default view)
- Theme settings (coming soon)

#### Activity Tab
- Recent activity log
- View all user actions (analysis uploads, profile updates, etc.)
- Activity timestamps and descriptions

### 3. Enhanced Dashboard

The dashboard (`/dashboard`) provides:
- Quick stats overview (total analyses, suspicious accounts, fraud rings)
- Analysis history table with:
  - Favorite toggle (star icon)
  - Tags display
  - Notes indicator
  - Download and view options
- Recent activity chart
- Quick insights

### 4. Analysis History Features

Each analysis can be:
- Marked as favorite (star icon)
- Tagged with custom labels
- Annotated with notes
- Downloaded as JSON
- Viewed in detail
- Deleted

## Database Schema

### Tables

1. **user_profiles**
   - Extended user information
   - Avatar URL, bio, location, website
   - Linked to auth.users

2. **user_settings**
   - User preferences
   - Notification settings
   - Analysis preferences

3. **analysis_history** (enhanced)
   - Analysis results storage
   - New fields: tags, notes, is_favorite
   - Full analysis data as JSONB

4. **saved_filters**
   - User's saved filter configurations
   - Quick access to common filters

5. **shared_analyses**
   - Analysis sharing functionality
   - Collaboration features

6. **activity_log**
   - User activity tracking
   - Action history with metadata

### Row Level Security (RLS)

All tables have RLS policies ensuring:
- Users can only access their own data
- Shared analyses have proper access control
- Activity logs are user-specific

## Setup Instructions

### 1. Apply Database Migration

Choose one of these methods:

**Using Supabase CLI:**
```bash
cd dashboard
supabase link --project-ref your-project-ref
supabase db push
```

**Using Supabase Dashboard:**
1. Go to SQL Editor in your Supabase dashboard
2. Copy contents of `dashboard/supabase/migrations/001_enhanced_user_system.sql`
3. Paste and execute

### 2. Configure Environment Variables

Ensure your `.env.local` has:
```env
NEXT_PUBLIC_SUPABASE_URL=your-supabase-url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

### 3. Test the Flow

1. Start the development server:
```bash
cd dashboard
npm run dev
```

2. Test the complete flow:
   - Sign up at `/auth/sign-up`
   - Verify email (if email confirmation is enabled)
   - Sign in at `/auth/login`
   - Upload a CSV file for analysis
   - View results in dashboard
   - Mark analysis as favorite
   - Visit profile at `/profile`
   - Update profile information
   - Check activity log

## API Functions

### Analysis Management

```typescript
// Save analysis
await saveAnalysis(fileName, fileSize, analysisData)

// Get history
const history = await getAnalysisHistory()

// Toggle favorite
await toggleAnalysisFavorite(id, isFavorite)

// Update tags
await updateAnalysisTags(id, ['tag1', 'tag2'])

// Update notes
await updateAnalysisNotes(id, 'My notes here')

// Delete analysis
await deleteAnalysis(id)
```

### User Profile

```typescript
// Get profile
const profile = await getUserProfile()

// Update profile
await updateUserProfile({
  full_name: 'John Doe',
  bio: 'Fraud analyst',
  location: 'New York',
  website: 'https://example.com'
})
```

### User Settings

```typescript
// Get settings
const settings = await getUserSettings()

// Update settings
await updateUserSettings({
  email_notifications: true,
  analysis_auto_save: true,
  default_view: 'graph'
})
```

### Activity Log

```typescript
// Log activity
await logActivity('analysis_uploaded', {
  file_name: 'transactions.csv',
  file_size: 1024
})

// Get recent activity
const activities = await getRecentActivity(10)
```

## UI Components

### Dashboard Shell
- Main dashboard layout
- User menu dropdown with profile link
- Tab navigation (My Dashboard, Analyze)

### Profile Shell
- Profile page layout
- Tab navigation (Profile, Settings, Activity)

### Analysis History Table
- Displays all user analyses
- Favorite toggle
- Tags and notes indicators
- Action buttons (view, download, delete)

### User Stats Cards
- Total analyses count
- Suspicious accounts flagged
- Fraud rings detected
- Average processing time

## Navigation

- **Home** (`/`) - Landing page
- **Dashboard** (`/dashboard`) - Main analysis dashboard
- **Profile** (`/profile`) - User profile and settings
- **Sign In** (`/auth/login`) - Authentication
- **Sign Up** (`/auth/sign-up`) - Registration

## Security

- All routes are protected by middleware
- RLS policies enforce data isolation
- User sessions are managed by Supabase Auth
- Sensitive operations require authentication

## Future Enhancements

- [ ] Avatar upload functionality
- [ ] Theme customization
- [ ] Advanced filter saving
- [ ] Analysis sharing UI
- [ ] Export to PDF
- [ ] Email notifications
- [ ] Team collaboration features
- [ ] API key management
- [ ] Webhook integrations

## Troubleshooting

### Migration Issues

If migration fails:
1. Check Supabase connection
2. Verify you have proper permissions
3. Check for existing table conflicts
4. Review error messages in Supabase logs

### Authentication Issues

If auth doesn't work:
1. Verify environment variables
2. Check Supabase project settings
3. Ensure email confirmation is configured
4. Check browser console for errors

### Data Not Showing

If data doesn't appear:
1. Check RLS policies are applied
2. Verify user is authenticated
3. Check browser console for errors
4. Verify database queries in Network tab

## Support

For issues or questions:
1. Check the migration README
2. Review Supabase documentation
3. Check application logs
4. Verify environment configuration
