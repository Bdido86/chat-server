package chat

import (
	desc "github.com/Bdido86/chat-server/pkg/api/chat_v1"
)

type Implementation struct {
	desc.UnimplementedChatV1Server
}

func NewImplementation() *Implementation {
	return &Implementation{}
}
