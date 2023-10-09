package chat

import (
	"context"
	"log/slog"

	"github.com/Bdido86/chat-server/pkg/api/chat_v1"
)

func (i *Implementation) Create(_ context.Context, req *chat_v1.CreateRequest) (*chat_v1.CreateResponse, error) {
	var result int64

	slog.Info("method Create input params:", "idFrom", req.GetIdFrom(), "idTo", req.GetIdTo())

	return &chat_v1.CreateResponse{
		Id: result,
	}, nil
}
