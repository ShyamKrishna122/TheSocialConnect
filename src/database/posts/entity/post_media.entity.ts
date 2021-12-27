import { BaseEntity, Column, Entity, ManyToOne, PrimaryGeneratedColumn } from "typeorm";
import { PostEntity } from "./post.entity";

@Entity("ScPostsMedia")
export class PostMediaEntity extends BaseEntity {
    @PrimaryGeneratedColumn()
    postMediaId!: string;

    @Column({
        nullable: false,
    })
    mediaType!: string;

    @Column({
        nullable: false,
    })
    mediaUrl!: string;


    @ManyToOne(() => PostEntity, (post) => post.postMedia)
    post!: PostEntity;

}