---
name: reference_calendar_business_personal_split
description: "Google Calendar structure after the 2026-07-16 restructure; primary \"Business\" is the Zoom/invite catch-all, \"Personal\" secondary holds genuinely-personal events"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 6a25d1a0-fe82-4176-91fd-4727a78cbec7
---

Mark's Google account is `mark@felicisholdings.com`. Its **primary** calendar was renamed to **"Business"** on 2026-07-16 and is the unavoidable catch-all: Google routes every accepted invitation and app-created event (Zoom meetings) to the primary, and there is no setting to redirect those to a secondary. Making primary = Business is what fixed Zoom scheduling to the business calendar.

A **"Personal"** secondary calendar (`c_b08f6f12800dbc0cc6a79596958489b7a7c09270350553f827aa264c3926800f@group.calendar.google.com`) was created and genuinely-personal recurring events (groceries, Euchre, CSA/farmshare pickups, anniversaries) moved there. "APR - Business Calendar" remains a separate secondary. Finance reminders (Pay Visa/AMEX) stayed on Business.

Mechanics learned: Google has no move-event-between-calendars API; `events.move` handles owned events but the MCP lacks it, so moves were done by recreating on the target (with full `recurrenceData`/reminders/location) then deleting the source master, `notificationLevel: NONE` to avoid attendee mail. Recurring series must be handled by master id, not instance id. See [[calendar_defaults]].
