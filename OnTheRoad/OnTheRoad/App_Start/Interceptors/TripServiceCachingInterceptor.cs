﻿using System;
using System.Web.Caching;
using Ninject.Extensions.Interception;
using OnTheRoad.Common;
using System.Web;

namespace OnTheRoad.App_Start.Interceptors
{
    public class TripServiceCachingInterceptor : IInterceptor
    {
        public void Intercept(IInvocation invocation)
        {
            var cache = CacheInstanceProvider.Instance;
            var callingMethodName = invocation.Request.Method.Name;
            var cachedValue = cache[callingMethodName];
            if (cachedValue == null)
            {
                invocation.Proceed();
                cache.Insert(invocation.Request.Method.Name, invocation.ReturnValue, null, DateTime.Now.AddMinutes(5), Cache.NoSlidingExpiration);
            }
            else
            {
                invocation.ReturnValue = cachedValue;
            }
        }
    }
}