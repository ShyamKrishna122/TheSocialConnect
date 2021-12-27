import { Request, Response } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { PostMediaEntity } from "../entity/post_media.entity";
import { PostRepository } from "./post.repository";

@EntityRepository(PostMediaEntity)
export class PostMediaRepository extends Repository<PostMediaEntity> {
    async addPostMedia(req: Request, res: Response) {
        let { postId } = req.params;
        let { mediaType, mediaUrl } = req.body;

        let postRepo = getCustomRepository(PostRepository);
        let post = await postRepo.findOne({
            postId: postId,
        });

        try {
            let postMedia = new PostMediaEntity();
            postMedia.mediaType = mediaType;
            postMedia.mediaUrl = mediaUrl;
            postMedia.post = post!;
            await postMedia.save();
            return res.send({
                message: "Post Media Added",
                added: true,
            });
        }
        catch (error) {
            return res.send({
                added: false,
                data: "Something went wrong",
            });
        }
    }
}