import { Router } from "express";
import { StoryMediaController } from "../controllers/story_media.controller";

const storyMediaRouter = Router();

//!POST
storyMediaRouter.post("/add/:storyId", StoryMediaController.addStoryMedia);

export { storyMediaRouter };