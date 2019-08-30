<cfcomponent output="false" hint="A MockBox awesome Component" implements="coldbox.system.cache.ICacheProvider">
<cffunction output="false" returntype="void" hint="Set the cache name" access="public" name="setName">
<cfargument required="true" type="any" hint="The cache name" name="name">
</cffunction>
<cffunction output="false" returntype="any" hint="Get the cache factory reference this cache provider belongs to" access="public" colddoc:generic="coldbox.system.cache.CacheFactory" name="getCacheFactory">
</cffunction>
<cffunction output="false" returntype="any" hint="If the cache provider implements it, this returns the cache's object store as type: coldbox.system.cache.store.IObjectStore" access="public" colddoc:generic="coldbox.system.cache.store.IObjectStore" name="getObjectStore">
</cffunction>
<cffunction output="false" returntype="any" hint="Get the cache statistics object as coldbox.system.cache.util.ICacheStats" access="public" colddoc:generic="coldbox.system.cache.util.ICacheStats" name="getStats">
</cffunction>
<cffunction output="false" returntype="any" hint="Clears an object from the cache by using its cache key. Returns false if object was not removed or did not exist anymore" access="public" colddoc:generic="boolean" name="clear">
<cfargument required="true" type="any" hint="The object cache key" name="objectKey">
</cffunction>
<cffunction output="false" returntype="any" hint="Get a cache objects metadata about its performance. This value is a structure of name-value pairs of metadata." access="public" colddoc:generic="struct" name="getCachedObjectMetadata">
<cfargument required="true" type="any" hint="The key of the object to lookup its metadata" name="objectKey">
</cffunction>
<cffunction output="false" returntype="any" hint="Get a structure of all the keys in the cache with their appropriate metadata structures. This is used to build the reporting.[keyX->[metadataStructure]]" access="public" colddoc:generic="struct" name="getStoreMetadataReport">
</cffunction>
<cffunction output="false" returntype="any" hint="Returns a flag indicating if the cache has reporting enabled" access="public" colddoc:generic="Boolean" name="isReportingEnabled">
</cffunction>
<cffunction output="false" returntype="void" hint="Set the cache factory reference for this cache" access="public" name="setCacheFactory">
<cfargument required="true" type="any" colddoc:generic="coldbox.system.cache.CacheFactory" name="cacheFactory">
</cffunction>
<cffunction output="false" returntype="void" hint="Expire all the elments in the cache (if supported by the provider)" access="public" name="expireAll">
</cffunction>
<cffunction output="false" returntype="any" hint="Get the name of this cache" access="public" name="getName">
</cffunction>
<cffunction output="false" returntype="void" hint="Clear all the cache elements from the cache" access="public" name="clearAll">
</cffunction>
<cffunction output="false" returntype="any" hint="sets an object in cache and returns true if set correctly, else false. With no statistic updates or listener updates" access="public" colddoc:generic="struct" name="setQuiet">
<cfargument required="true" type="any" hint="The object cache key" name="objectKey">
<cfargument required="true" type="any" hint="The object to cache" name="object">
<cfargument required="false" type="any" hint="The timeout to use on the object (if any, provider specific)" name="timeout">
<cfargument required="false" type="any" hint="The idle timeout to use on the object (if any, provider specific)" name="lastAccessTimeout">
<cfargument hint="A map of name-value pairs to use as extra arguments to pass to a providers set operation" required="false" type="any" colddoc:generic="struct" name="extra">
</cffunction>
<cffunction output="false" returntype="any" hint="Check if an object is in cache, if not found it records a miss." access="public" colddoc:generic="struct" name="lookup">
<cfargument required="true" type="any" hint="The key of the object to lookup." name="objectKey">
</cffunction>
<cffunction output="false" returntype="any" hint="Clears an object from the cache by using its cache key. Returns false if object was not removed or did not exist anymore without doing statistics or updating listeners" access="public" colddoc:generic="boolean" name="clearQuiet">
<cfargument required="true" type="any" hint="The object cache key" name="objectKey">
</cffunction>
<cffunction output="false" returntype="any" hint="Get an object from the cache without updating stats or listners" access="public" name="getQuiet">
<cfargument required="true" type="any" hint="The object key" name="objectKey">
</cffunction>
<cffunction output="false" returntype="any" hint="Has the object key expired in the cache" access="public" colddoc:generic="boolean" name="isExpired">
<cfargument required="true" type="any" hint="The object key" name="objectKey">
</cffunction>
<cffunction output="false" returntype="any" hint="Get the structure of configuration parameters for the cache" access="public" colddoc:generic="struct" name="getConfiguration">
</cffunction>
<cffunction output="false" returntype="void" hint="Clear the cache statistics" access="public" name="clearStatistics">
</cffunction>
<cffunction output="false" returntype="void" hint="Set the event manager for this cache" access="public" name="setEventManager">
<cfargument required="true" type="any" hint="The event manager class" name="eventManager">
</cffunction>
<cffunction output="false" returntype="any" hint="Returns a flag indicating if the cache is ready for operation" access="public" colddoc:generic="Boolean" name="isEnabled">
</cffunction>
<cffunction output="false" returntype="any" hint="Check if an object is in cache, no stats updated or listeners" access="public" colddoc:generic="struct" name="lookupQuiet">
<cfargument required="true" type="any" hint="The key of the object to lookup." name="objectKey">
</cffunction>
<cffunction output="false" returntype="any" hint="sets an object in cache and returns true if set correctly, else false." access="public" colddoc:generic="struct" name="set">
<cfargument required="true" type="any" hint="The object cache key" name="objectKey">
<cfargument required="true" type="any" hint="The object to cache" name="object">
<cfargument required="false" type="any" hint="The timeout to use on the object (if any, provider specific)" name="timeout">
<cfargument required="false" type="any" hint="The idle timeout to use on the object (if any, provider specific)" name="lastAccessTimeout">
<cfargument hint="A map of name-value pairs to use as extra arguments to pass to a providers set operation" required="false" type="any" colddoc:generic="struct" name="extra">
</cffunction>
<cffunction output="false" returntype="void" hint="This method makes the cache ready to accept elements and run.  Usualy a cache is first created (init), then wired and then the factory calls configure() on it" access="public" name="configure">
</cffunction>
<cffunction output="false" returntype="void" hint="Set the entire configuration structure for this cache" access="public" name="setConfiguration">
<cfargument hint="The configuration structure" required="true" type="any" colddoc:generic="struct" name="configuration">
</cffunction>
<cffunction output="false" returntype="void" hint="Shutdown command issued when CacheBox is going through shutdown phase" access="public" name="shutdown">
</cffunction>
<cffunction output="false" returntype="any" hint="Get this cache managers event listener manager" access="public" name="getEventManager">
</cffunction>
<cffunction output="false" returntype="void" hint="Send a reap or flush command to the cache" access="public" name="reap">
</cffunction>
<cffunction output="false" returntype="any" hint="Returns a list of all elements in the cache, whether or not they are expired." access="public" colddoc:generic="array" name="getKeys">
</cffunction>
<cffunction output="false" returntype="any" hint="Get a key lookup structure where cachebox can build the report on. Ex: [timeout=timeout,lastAccessTimeout=idleTimeout].  It is a way for the visualizer to construct the columns correctly on the reports" access="public" colddoc:generic="struct" name="getStoreMetadataKeyMap">
</cffunction>
<cffunction output="false" returntype="any" hint="Get the number of elements in the cache" access="public" colddoc:generic="numeric" name="getSize">
</cffunction>
<cffunction output="false" returntype="void" hint="Expires an object from the cache by using its cache key. Returns false if object was not removed or did not exist anymore (if supported by the provider)" access="public" name="expireObject">
<cfargument required="true" type="any" hint="The object cache key" name="objectKey">
</cffunction>
<cffunction output="false" returntype="any" hint="Get an object from the cache and updates stats" access="public" name="get">
<cfargument required="true" type="any" hint="The object key" name="objectKey">
</cffunction>
</cfcomponent>