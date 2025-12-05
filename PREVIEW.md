# pub.dev 배포 전 미리보기 방법

pub.dev에는 공식적인 미리보기 기능이 없지만, 다음 방법들로 배포 전에 확인할 수 있습니다:

## 1. 패키지 검증 (Dry Run)

```bash
flutter pub publish --dry-run
```

이 명령어는:
- 패키지 구조 검증
- 필수 파일 확인
- 메타데이터 검증
- 경고 및 오류 표시

## 2. README 미리보기

### 방법 A: GitHub에 업로드
1. GitHub 저장소 생성
2. README.md 파일 업로드
3. GitHub에서 README 렌더링 확인

### 방법 B: 로컬 마크다운 뷰어
- VS Code: Markdown Preview 확장 사용
- 온라인 도구: https://dillinger.io/ 또는 https://stackedit.io/
- macOS: `open -a "Marked 2" README.md` (Marked 2 설치 시)

## 3. pub.dev 점수 확인

배포 후 자동으로 계산되는 점수 항목:
- ✅ **Popularity**: 다운로드 수
- ✅ **Health**: 코드 품질, 문서화
- ✅ **Maintenance**: 최근 업데이트, 이슈 해결
- ✅ **Overall Score**: 종합 점수

## 4. 배포 전 체크리스트

- [ ] `pubspec.yaml`의 모든 필드가 올바르게 설정되었는지 확인
- [ ] `README.md`에 충분한 설명과 예제가 있는지 확인
- [ ] `CHANGELOG.md`가 작성되었는지 확인
- [ ] `LICENSE` 파일이 있는지 확인
- [ ] 스크린샷이 추가되었는지 확인 (선택사항)
- [ ] `flutter pub publish --dry-run`에서 경고가 없는지 확인
- [ ] 모든 테스트가 통과하는지 확인 (`flutter test`)

## 5. 실제 배포

```bash
flutter pub publish
```

배포 후:
- https://pub.dev/packages/chat_group_avatar 에서 확인
- 점수는 몇 분 후 자동으로 계산됨

