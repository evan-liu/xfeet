package xfeet.utils
{
    import p2.reflect.Reflection;
    /**
     * Check if a Class is a suite.
     * @param reflection    Reflection of the target class.
     */
    public function isSuite(reflection:Reflection):Boolean
    {
        return reflection.getMetaDataByName("Suite") != null;
    }
}