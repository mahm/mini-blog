export type IUser = {
  id: string
  name: string
}

export type ITopic = {
  id: string
  body: string
  updatedAt: string
  craetedAt: string
  user: IUser
}
