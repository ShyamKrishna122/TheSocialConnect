import { Request, Response } from "express";
import { EntityRepository, getCustomRepository, Repository } from "typeorm";
import { PostRepository } from "../../posts/repository/post.repository";
import { UserRepository } from "../../user/repository/user.repository";
import { CommentEntity } from "../entity/comment.entity";

@EntityRepository(CommentEntity)
export class CommentRepository extends Repository<CommentEntity> {
  async addComment(req: Request, res: Response) {
    let { postId } = req.params;
    let { userEmail, commentText } = req.body;

    let postRepo = getCustomRepository(PostRepository);
    let post = await postRepo.findOne({ postId: postId });

    let userRepo = getCustomRepository(UserRepository);
    let user = await userRepo.findOne({ userEmail: userEmail });

    try {
      let comment = new CommentEntity();
      comment.commentText = commentText;
      comment.post = post!;
      comment.user = user!;
      await comment.save();
      return res.send({
        message: "Comment added",
        added: true,
      });
    } catch (error) {
      return res.send({
        message: "Something went wrong",
        added: false,
      });
    }
  }

  async getPostComments(req: Request, res: Response) {
    let { postId } = req.params;

    try {
      let commentData = await this.createQueryBuilder("comment")
        .leftJoinAndSelect("comment.user", "user")
        .leftJoinAndSelect("user.info","info")
        .where("comment.postPostId = :id", { id: postId })
        .getMany();
      if (commentData !== undefined) {
        return res.send({
          data: commentData,
          filled: true,
          received: true,
        });
      } else {
        return res.send({
          data: "Fill some info",
          filled: false,
          received: true,
        });
      }
    } catch (error) {
      return res.send({
        data: "Something went wrong",
        received: false,
      });
    }
  }
}
