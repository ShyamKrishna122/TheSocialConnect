import Router from "express";
import { StoryViewController } from "../controllers/story_view.controller";

const viewRouter = Router();

//!POST
viewRouter.get("/add/:storyId/:userEmail", StoryViewController.addStoryView);

//!GET
viewRouter.get("/isViewed/:storyId/:userEmail", StoryViewController.isViewedByUser);

//!GET
viewRouter.get("/:storyId", StoryViewController.getStoryViewCount);

export { viewRouter };