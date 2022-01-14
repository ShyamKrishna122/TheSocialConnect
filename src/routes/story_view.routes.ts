import Router from "express";
import { StoryViewController } from "../controllers/story_view.controller";

const viewRouter = Router();

//!POST
viewRouter.get("/add/:storyMediaId/:userEmail", StoryViewController.addStoryView);

//!GET
viewRouter.get("/isViewed/:storyMediaId/:userEmail", StoryViewController.isViewedByUser);

//!GET
viewRouter.get("/:storyMediaId", StoryViewController.getStoryViewCount);

export { viewRouter };