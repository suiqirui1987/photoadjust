package com
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import mx.controls.ProgressBar;
	import mx.preloaders.DownloadProgressBar;


       
    public class Preloader extends DownloadProgressBar   
    {   

	 
           
        public function Preloader()   
        {   
            super();   
            DOWNLOAD_PERCENTAGE = 100;
        }   
        // Progress bar color 
        protected var barColor:uint = 0xB9FFFF;
        protected var percentText:TextField;
        private var pogressBarSprite:Sprite;

        private var    _maximum:Number = 0;
        private var    _value:Number = 0;
        private var isDownloaded:Boolean = false;
    
        /**
         *  The TextFormat of the percentage TextField
         */
        protected function get percentTextFormat():TextFormat
        {
            var tf:TextFormat= new TextFormat();
            tf.color = 0x34362B;
            tf.font = "Impact";
            tf.size = 12;
            return tf;
        }
        
        /**
         *  Creates the subcomponents of the display.
         */
        override protected function createChildren():void
        {
            pogressBarSprite = new Sprite;
            addChild(pogressBarSprite);
            percentText = new TextField();
            addChild(percentText);
            percentText.defaultTextFormat = percentTextFormat;
            percentText.selectable =false;
            percentText.width = 50;
            percentText.x=(this.stageWidth-this.width)/2;
            percentText.y=(this.stageHeight-this.height)/2;
        }
            
        /**
         *  Call updateDisplay() from the setProgress method of the superclass, 
         *     where we get the current download information.
         */
        override protected function setProgress(completed:Number, total:Number):void
        {
            if (!isNaN(completed) && !isNaN(total) &&  completed >= 0 && total > 0)
            {
                _value = Number(completed);
                _maximum = Number(total);
                updateDisplay();
            }    
        } 
        
        /**
         *  Update the progress bar and the percentage text. 
         */
        private function updateDisplay():void
        {
            if(!isDownloaded)    
            {
                var percentage:Number = Math.round(getPercentLoaded(_value, _maximum));
            
                if(percentage == 99)
                    isDownloaded = true;
                drawProgressBar(percentage);        
                percentText.text = percentage + "%";
            }
        }
        
        /**
         *  Draw the progress bar. 
         */
        private function drawProgressBar(percentage:Number):void
        {
            var barWidth:Number = 200 *	 percentage / 100;
            var g:Graphics = pogressBarSprite.graphics;
            g.clear(); 
            g.lineStyle(1,0x0099FF,1);
            g.beginFill(barColor,0);
            g.drawRect((this.stageWidth-200)/2,(this.stageHeight-20)/2, 200, 20);
            
            g.beginFill(barColor);
            g.drawRect((this.stageWidth-200)/2,(this.stageHeight-20)/2, barWidth, 20);
            g.endFill();
        }
        
    
 
  
    }  
}