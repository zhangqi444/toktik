import { ModelInit, MutableModel, PersistentModelConstructor } from "@aws-amplify/datastore";

export enum ModelAttributeTypes {
  BINARY = "binary",
  BINARY_SET = "binarySet",
  BOOL = "bool",
  LIST = "list",
  MAP = "map",
  NUMBER = "number",
  NUMBER_SET = "numberSet",
  STRING = "string",
  STRING_SET = "stringSet",
  NULL = "_null"
}

export declare class ModelPostExConnection {
  readonly items?: (PostEx | null)[];
  readonly nextToken?: string;
  readonly startedAt?: number;
  constructor(init: ModelInit<ModelPostExConnection>);
}

export declare class PostEx {
  readonly id: string;
  readonly text?: string;
  readonly user?: User;
  readonly music?: Music;
  readonly attachments?: string;
  readonly likeCount?: number;
  readonly commentCount?: number;
  readonly shareCount?: number;
  readonly viewCount?: number;
  readonly isLiked?: Like;
  constructor(init: ModelInit<PostEx>);
}

type UserMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type MusicMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type LikeMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type PostMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type ViewMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type ShareMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

type CommentMetaData = {
  readOnlyFields: 'createdAt' | 'updatedAt';
}

export declare class User {
  readonly id: string;
  readonly nickname?: string;
  readonly portrait?: string;
  readonly bio?: string;
  readonly birth?: string;
  readonly gender?: number;
  readonly city?: string;
  readonly profession?: string;
  readonly username?: string;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<User, UserMetaData>);
  static copyOf(source: User, mutator: (draft: MutableModel<User, UserMetaData>) => MutableModel<User, UserMetaData> | void): User;
}

export declare class Music {
  readonly id: string;
  readonly url?: string;
  readonly img?: string;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Music, MusicMetaData>);
  static copyOf(source: Music, mutator: (draft: MutableModel<Music, MusicMetaData>) => MutableModel<Music, MusicMetaData> | void): Music;
}

export declare class Like {
  readonly id: string;
  readonly user?: User;
  readonly post?: Post;
  readonly value?: boolean;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Like, LikeMetaData>);
  static copyOf(source: Like, mutator: (draft: MutableModel<Like, LikeMetaData>) => MutableModel<Like, LikeMetaData> | void): Like;
}

export declare class Post {
  readonly id: string;
  readonly text?: string;
  readonly user?: User;
  readonly music?: Music;
  readonly attachments?: string;
  readonly likeCount?: number;
  readonly commentCount?: number;
  readonly shareCount?: number;
  readonly viewCount?: number;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Post, PostMetaData>);
  static copyOf(source: Post, mutator: (draft: MutableModel<Post, PostMetaData>) => MutableModel<Post, PostMetaData> | void): Post;
}

export declare class View {
  readonly id: string;
  readonly post?: Post;
  readonly user?: User;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<View, ViewMetaData>);
  static copyOf(source: View, mutator: (draft: MutableModel<View, ViewMetaData>) => MutableModel<View, ViewMetaData> | void): View;
}

export declare class Share {
  readonly id: string;
  readonly to?: string;
  readonly user?: User;
  readonly post?: Post;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Share, ShareMetaData>);
  static copyOf(source: Share, mutator: (draft: MutableModel<Share, ShareMetaData>) => MutableModel<Share, ShareMetaData> | void): Share;
}

export declare class Comment {
  readonly id: string;
  readonly user?: User;
  readonly post?: Post;
  readonly text?: string;
  readonly createdAt?: string;
  readonly updatedAt?: string;
  constructor(init: ModelInit<Comment, CommentMetaData>);
  static copyOf(source: Comment, mutator: (draft: MutableModel<Comment, CommentMetaData>) => MutableModel<Comment, CommentMetaData> | void): Comment;
}