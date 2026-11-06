# codex-config

OpenAI Codex CLI 개인 전역 설정 — **claude-config의 형제 repo**. Codex가 주도하는 모드(표 B/C)의 지침을 담는다.

배포물: `config/AGENTS.md` → `~/.codex/AGENTS.md` (Codex가 읽는 전역 지침).

## 구조

| 경로 | 역할 |
|---|---|
| `config/AGENTS.md` | Codex 전역 지침 (`~/.codex/AGENTS.md`로 링크/복사) |
| `install-codex-linux.sh` | 설치 (복사 기본, `--link` 개발 머신) |

## 설치

```bash
./install-codex-linux.sh          # 복사 모드
./install-codex-linux.sh --link   # 링크 모드 (개발 머신 — 수정 즉시 반영)
```

`~/.codex/config.toml`(모델·승인·프로젝트 trust 등 개인 설정)은 **건드리지 않는다.**

## 형제·다리 (멀티모델)

- **claude-config**: Claude 쪽(표 A). `~/.claude` 배포. 평소 주력.
- **codex-config**(이 repo): Codex 쪽(표 B/C). `~/.codex/AGENTS.md`. Claude 한도 시 승격.
- **공유 계약**: 각 프로젝트의 `.claude/spec.md` · `AGENTS.md` · `.claude/decisions-needed.md`.
- **브리지**: Codex→Claude `claude -p`, Codex→DeepSeek 로컬 Ollama(OpenAI 호환). Claude 쪽은 `codex review`/`codex exec`로 역방향.
- **우산(선택)**: `ai-config`가 claude-config·codex-config를 git submodule로 연결.

## 참고

AGENTS.md는 Codex와 Claude Code 양쪽이 읽는 교차 도구 앵커(Claude는 CLAUDE.md 없을 때 폴백). 프로젝트별 AGENTS.md가 있으면 전역과 병합된다.
