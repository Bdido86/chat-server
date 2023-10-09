package chat

import (
	"context"
	"log/slog"

	"github.com/Bdido86/chat-server/pkg/api/chat_v1"

	"google.golang.org/protobuf/types/known/emptypb"
)

func (i *Implementation) Delete(_ context.Context, req *chat_v1.DeleteRequest) (*emptypb.Empty, error) {
	slog.Info("method Delete input params", "id", req.GetId())

	return &emptypb.Empty{}, nil
}
