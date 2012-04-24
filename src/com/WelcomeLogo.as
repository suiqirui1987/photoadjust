package com
{
	import flash.display.Loader;   
    import flash.utils.ByteArray;   
       
    public class WelcomeLogo extends Loader   
    {   
        [Embed(source="../asset/preloader.png", mimeType="application/octet-stream")]   
        public var WelcomeScreenGraphic:Class;   
        public function WelcomeLogo()   
        {   
            this.loadBytes(new WelcomeScreenGraphic() as ByteArray);   
        }   
  
    }   
}