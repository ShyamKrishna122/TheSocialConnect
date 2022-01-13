import Router from "express";
import { StoryController } from "../controllers/story.controller";

const storyRouter = Router();

//!POST
storyRouter.post("/add/:userEmail", StoryController.addStory);

//!GET
storyRouter.get("/fetch/:userEmail", StoryController.fetchStory);

//!GET
storyRouter.get("/storyByUser/:userEmail", StoryController.fetchStoryByUser);

//!DELETE
storyRouter.delete("/delete/:storyId", StoryController.deleteStory);

export { storyRouter };
