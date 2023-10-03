package app

import "github.com/Bdido86/chat-server/internal/api/chat"

type serviceProvider struct {
	chatImpl *chat.Implementation
}

func newServiceProvider() *serviceProvider {
	return &serviceProvider{}
}

func (s *serviceProvider) ChatImpl() *chat.Implementation {
	if s.chatImpl == nil {
		s.chatImpl = chat.NewImplementation()
	}

	return s.chatImpl
}
