# Video Upload Workflow Tasks

## Goal
Show newly uploaded videos at the top of the feed immediately after upload.

## Implementation Checklist

### 1. Modify FeedScreen ✅
- [x] Add `initialVideo` parameter to `FeedScreen` widget
- [x] Update constructor to accept optional `initialVideo` and `isNewUpload` flag
- [x] Modify `_loadVideos()` to insert `initialVideo` at start of feed if provided and `isNewUpload` is true
- [x] Test that feed displays correctly with and without `initialVideo`

### 2. Update UploadScreen ✅
- [x] Add `getVideo` call after successful upload
- [x] Modify `Navigator.pop()` to return the new video
- [x] Test that upload returns video object correctly

### 3. Update Bottom Navigation (Next Step) 🚧
- [ ] Modify upload button to await returned video
- [ ] Add logic to switch to feed tab when video is returned
- [ ] Update feed screen with new video
- [ ] Test navigation flow works correctly

## Testing Checklist
- [ ] Upload new video successfully
- [ ] Return to feed screen automatically
- [ ] New video appears at top of feed
- [ ] Video plays correctly
- [ ] Feed refreshes properly
- [ ] Navigation between tabs works
- [ ] App restart shows normal feed order

## Notes
- Keep feed screen in navigation stack
- No persistent state needed
- Maintain existing navigation patterns 