import Router from "express";
import { FollowController } from "../controllers/follow.controller";

const followRouter = Router();

//!POST
followRouter.post("/add/:followingId", FollowController.addFollowing);

//!POST
followRouter.post("/isFollowing/:followingId", FollowController.isFollowingUser);

//!DELETE
followRouter.delete("/remove/:followingId", FollowController.removeFollowing);

export { followRouter };
