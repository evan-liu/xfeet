package tests.collection
{
    [Unit(label="Comparing cost of constructing and populating different collection types", loops="1")]
    public class Collections
    {
        //======================================================================
        //  Variables
        //======================================================================
        private var loops:int = 1000000;
        //======================================================================
        //  Public methods
        //======================================================================
        [Test]
        public function array():void {
            var list:Array = [];
            for (var i:uint=0; i<loops; i++) {
                list[i] = i/3;
            }
        }
        [Test]
        public function arrayFixed():void {
            var list:Array = new Array(loops);
            for (var i:uint=0; i<loops; i++) {
                list[i] = i/3;
            }
        }
        [Test]
        public function vector():void {
            var list:Vector.<Number> = new Vector.<Number>();
            for (var i:uint=0; i<loops; i++) {
                list[i] = i/3;
            }
        }
        [Test]
        public function vectorFixed():void {
            var list:Vector.<Number> = new Vector.<Number>(loops);
            for (var i:uint=0; i<loops; i++) {
                list[i] = i/3;
            }
        }
        [Test]
        public function linkedList():void {
            var o:LinkedList;
            for (var i:uint=0; i<loops; i++) {
                o = new LinkedList(i/3,o);
            }
        }
    }
}

class LinkedList {

    public var next:LinkedList;
    public var value:Number;

    public function LinkedList(value:Number,next:LinkedList) {
        this.value = value;
        this.next = next;
    }

}