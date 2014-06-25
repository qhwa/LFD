package
{
    import flash.display.Sprite;
    import flash.events.Event;

    public class Main extends Sprite
    {

        public function Main() {
            if( stage ) {
                init();
            } else {
                addEventListener( Event.ADDED_TO_STAGE, init );
            }
        }

        private function init( evt:Event = null ):void
        {
            removeEventListener( Event.ADDED_TO_STAGE, init );

            //here start
            //..
        }
    }

}
