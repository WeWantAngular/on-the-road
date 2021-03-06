﻿using System;
using OnTheRoad.Logic.Contracts;
using OnTheRoad.Domain.Models;
using OnTheRoad.Domain.Enumerations;

namespace OnTheRoad.Logic.Utils
{
    public class ReviewAddHelper : IReviewAddHelper
    {
        private readonly IUserGetService userService;
        private readonly IRatingService ratingService;

        public ReviewAddHelper(IUserGetService userService, IRatingService ratingService)
        {
            if (userService == null)
            {
                throw new ArgumentNullException("userService cannot be null!");
            }

            if (ratingService == null)
            {
                throw new ArgumentNullException("ratingService cannot be null!");
            }

            this.userService = userService;
            this.ratingService = ratingService;
        }

        public IRating GetRatingByValue(RatingEnum value)
        {
            return this.ratingService.GetRatingByValue(value);
        }

        public IUser GetUserByUsername(string username)
        {
            return this.userService.GetUserInfo(username);
        }
    }
}
