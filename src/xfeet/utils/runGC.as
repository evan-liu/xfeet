package xfeet.utils
{
    import flash.net.LocalConnection;
    public function runGC():void
    {
        try
        {
            new LocalConnection().connect("_FORCE_GC_");
            new LocalConnection().connect("_FORCE_GC_");
        }
        catch(e:*) {}
    }
}