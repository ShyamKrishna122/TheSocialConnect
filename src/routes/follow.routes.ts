import Router from "express";
import { FollowController } from "../controllers/follow.controller";

const followRouter = Router();

//!GET
followRouter.get("/add/:userEmail/:followingId", FollowController.addFollowing);

//!GET
followRouter.get("/isFollowing/:userEmail/:followingId", FollowController.isFollowingUser);

//!GET
followRouter.get("/followingCount/:userEmail", FollowController.getFollowingCount);

//!GET
followRouter.get("/followersCount/:userEmail", FollowController.getFollowersCount);

//!DELETE
followRouter.delete("/remove/:userEmail/:followingId", FollowController.removeFollowing);

//!GET
followRouter.get("/follower/:userEmail", FollowController.getFollowersInfo);

//!GET
followRouter.get("/following/:userEmail", FollowController.getFollowingInfo);

export { followRouter };
