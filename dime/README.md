#  Welcome to Dime

## Final Milestone Notes

Lots of my original idea has changed from what I had originally envisioned. Part of this has to be because of lack of knowledge regarding about practical ways to implement certain details. Some are based on compromises that had to be made because of limitations from the API. The way that my app works is deceptively simple, and looks obvious in what made sense looking back. However, I received lots of feedback from my peers, friends, and family on what would make the most sense for a Minimum Viable Product.

This leads me to the current working vesion of dime. I believe this iteration to be the best version made thus far, but lots of changes could be made to improve the application. For instance, I found that users really enjoyed seeing what activities/events are on sale in the surrounding area. People also enjoy looking around for other deals outside their immediate vicinity. If I were to continue working on this app, I can see it moving towards location-based social events. I don't believe my app is inherently flawed, but that the market is already saturated with couponing deal applications. Nevertheless, I found this app to be a great experience. When working on this over the weekend at the library, I saw that Papa John's had a pizza dillivery deal that led me to order pizza that same day. At the very least, this app concept satisfied one person. 

### Bugs that need to be fixed

In its current form, my application does not delete annotations, as a bug prevents future annotations from being written to. I had considered using GeoFire and implementing Firebase for the backend database, but found that to be uncessary as MapView already handles annotations without completely destroying memory. Also, The annotations only show up after performing a touch gesture such as tapping on the screen or zooming in/out. As a Graphic Communication Major, my UI was mediocre at best and could have used more attention. In certain occasions, race conditions occur when calling the API before a location was established. This has been fixed, but this might possibly need further testing to see if this issue can be replicated after making the fix. 


## Milestone 3 Notes

This app was created for assisting in the experience of buying items instore. This app asks for your location, and based on that location, will generate coupons in your area. As of now, I have no need for the location modal class given that contained a user's location because of my newfound knowledge of CLLocation. As for Google Maps API, I am not utilizing any feature of the app currently, so will be using MapView as Google Maps asks for some money. 

My data source is from the groupon API, but I am currently using a Sample API key. Groupon doesn't want to give the API key to individuals, but I have attempted to get around this by using my work at the Cal Poly Corporation to apply for that full key. In the case I cannot get a key, the sample works perfectly fine, but with some limited functionality. In the scope of this project, I believe it will not affect much, but would be more of a problem if I were to release the app to the appstore.  On my Simulator, my location is 35.252909, -120.688419. The API call pulls the correct information, but I have a bug with my location getting updated and taking me to other locations. 

What I need to do is the query the coupons that show up on mapkit and have them show up on the map. I will then use annotations to segue to more information related to the coupon and the coupon itself, link, discount code, etc. Right now, I will use my current location to show how the segue will work, but I plan to implement this soon. As a person who likes design, I plan on using whatever time I have at the end to make the app as beatiful as possible. Right now, I have made a quick logo that has been included as an icon for this app. 
