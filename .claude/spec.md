# spec — codex-config 기능 패리티 (Codex가 구현)

## 목표
claude-config의 기능을 **Codex 네이티브**로 제공해, Claude가 한도로 멈춰도(표 B) Codex 단독으로 동일 수준 개발이 되게 한다. 참조 소스: `~/.claude/skills/*/SKILL.md`, `~/.claude/hooks/*`, `~/.claude/CLAUDE.md`, 이 repo의 `config/AGENTS.md`.

## 비목표
- claude-config 내용 **복제 금지**(단일 소스 참조). Codex 메커니즘으로 **재구현**만.
- Claude Code 전용 기능을 억지로 흉내 금지 — 불가하면 사유 기록(만점 처리 금지).

## 인수 기준 (각 항목 Codex로 실제 동작 확인)
1. **Codex 스킬**: autodev·project-init·quality-init·xreview·howto 를 Codex 스킬 포맷으로. 내용은 claude SKILL.md 기반, Codex 드라이버 맞춤(xreview의 "다른 모델"=`claude -p`+로컬 DeepSeek).
2. **모델 라우팅**(Codex 드라이버): 어려운 설계=Astra(또는 가능 시 `claude -p` Fable) · 구현=Codex · 대량/간단생성=로컬 DeepSeek(`$DEEPSEEK_BASE_URL`) · 교차리뷰=`claude -p`+DeepSeek. 외부 모델 읽기전용, 수정은 Codex만.
3. **사용량 누적**: Codex 사용량을 `~/.codex/history.jsonl`(또는 로그)에서 모델별 토큰·비용(KRW)으로 집계 → `quality/usage.json` 호환. ⚠️ 제약: ChatGPT 구독 "% 한도"는 API 미노출 → 토큰 기반 집계까지만, % 게이지·자동정지는 "불가" 기록.
4. **오케스트레이션**: Codex 네이티브 멀티에이전트(`codex` agents/app-server)로 팬아웃·리뷰. 가능 범위까지.
5. **상태줄/가드**: Codex TUI 지원 범위에서 모델·git·사용량 표시. 미지원 항목은 사유 기록.
6. **품질 체계**: codex-config에 `scripts/quality-score.*`→`quality/score.json`(claude-config 방식). 기준점 90.
7. **설치 반영**: 새 스킬/파일이 `install-codex-linux.sh`로 `~/.codex`에 배포되게.

## 완성
인수 기준 ≥90% 충족 + 각 항목 실동작 검증 + 불가 항목 사유 기록. 열린 결정은 `.claude/decisions-needed.md`.

## 방식
AGENTS.md 규율(설계→인수테스트→구현→리뷰) 따름. 사람 승인 게이트 = 이 spec. 진행 중 막히면(3회) 중단·기록.
