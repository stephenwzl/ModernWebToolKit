# ModernWebToolKit

## Parts

* AppCenter  
abstract for web applications. Including register apps, sync apps' info, install web apps into file system.

* Web Application  
the whole application will be packageg into a zip bundle. There also will be some extra info such as: icon, name ,launch parameters provided in that bundle.

* Offline-bundle  
offline app bundle was stored in CDN(content distribution network), the bunle's link will be store in app's info in AppCenter. It's a kind of zip bundle in nature.

* Webview  
loading web content from local file system. Inject Javascript API to be invoked by the content.

* JSAPI  
some hight level APIs for web developers to invoke for some purpose. There will be default implementation, but there also will be able to register JSAPI plugins for extra implementation.
 


## Author

stephenwzl, wangzhilong.stephen@bytedance.com

## License

ModernWebToolKit is available under the MIT license. See the LICENSE file for more info.
