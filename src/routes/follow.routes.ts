import Router from "express";
import { FollowController } from "../controllers/follow.controller";

const followRouter = Router();

//!GET
followRouter.get("/add/:userEmail/:followingId", FollowController.addFollowing);

//!GET
followRouter.get("/isFollowing/:userEmail/:followingId", FollowController.isFollowingUser);

//!DELETE
followRouter.delete("/remove/:userEmail/:followingId", FollowController.removeFollowing);

export { followRouter };
