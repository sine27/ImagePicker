# ImagePicker

### I'm using the MVVM for this project

Components (cell, button)

DataModels (image data model)

Handlers (API handler)

Helpers (extensions, shared functions)

ViewControllers

ViewModels (data controller for view controllers)

### Time Spent:

v1: 8h

v2: 8h + 2h = 10h

### Frameworks:

Alamofire (API handler), AlamofireImage (image lazy load with animation)

### Icons (check, uncheck) are made by Scketch

## Done

### Reqired

- Allow user to select between two sources: local photo library or photo list from Unsplash(50 latest pictures)
- Get images from the selected source, and display them in a grid layout
- Allow user to select image, and pass the selected image to the caller of the picker
- Support image preview (e.g. tap/hold to enlarge the image) \*v2
- Support remove the photo in preview model if selected \*v2

### Optional

- Support multiple selection
- Support unselect

### Demo

#### V1
<img src='https://github.com/sine27/ImagePicker/blob/master/v1.gif?raw=true' title='image picker' width='270' alt='Video Walkthrough' />

#### v2

<img src='https://github.com/sine27/ImagePicker/blob/master/v2.gif?raw=true' title='image picker' width='270' alt='Video Walkthrough' />

## TODO (if time allows)

- Allow load more images from unsplash if reaching the bottom
- Local storage

## Note

- PHAsset.requestContentEditingInput failed to fetch urls of local library for images on icloud. Can use PHImageManager.requestImageData, but need redesign ImageDataModel.
