#  Welcome to Dime
Pre-release Notes 0.5

This app was created for assisting in the experience of buying items instore. This app asks for your location, and based on that location, will generate coupons in your area. 
As of now, I have no need for the location modal class given that contained a user's location because of my newfound knowledge of CLLocation. As for Google Maps API, I am not utilizing any feature of the app currently, so will be using MapView as Google Maps asks for some money. 

My data source is from the groupon API, but I am currently using a Sample API key. Groupon doesn't want to give the API key to individuals, but I have attempted to get around this by using my work at the Cal Poly Corporation to apply for that full key. In the case I cannot get a key, the sample works perfectly fine, but with some limited functionality. In the scope of this project, I believe it will not affect much, but would be more of a problem if I were to release the app to the appstore.  On my Simulator, my location is 35.252909, -120.688419. The API call pulls the correct information, but I have a bug with my location getting updated and taking me to other locations. 

What I need to do is the query the coupons that show up on mapkit and have them show up on the map. I will then use annotations to segue to more information related to the coupon and the coupon itself, link, discount code, etc. Right now, I will use my current location to show how the segue will work, but I plan to implement this soon. As a person who likes design, I plan on using whatever time I have at the end to make the app as beatiful as possible. Right now, I have made a quick logo that has been included as an icon for this app. 


Also, certain coupons can be redeemed at multiple locations, so I have to mak
 0
